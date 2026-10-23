// Builds the static site into ./dist.
// Pulls live content from Supabase at deploy time and writes it into the HTML, so search engines
// see every project, skill and role as plain markup. If Supabase is unreachable, the built-in
// copy in index.html (same as data.fallback.json) is kept. No dependencies: Node 18+.
import { readFile, writeFile, mkdir, cp, rm } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
import { createHash } from 'node:crypto';

const here = dirname(fileURLToPath(import.meta.url));
const out = join(here, '..', 'dist');
const SB = 'https://ltzpgwdxosnitvojnbth.supabase.co/rest/v1/';
const SBK = 'sb_publishable_aPVxNjVgun4K3aVlWNhXJQ_BGe-IYaa'; // public, publishable key (RLS limits it to reads)
// the public domain; SITE_URL can override it (Render's own *.onrender.com address is deliberately not used)
const SITE = (process.env.SITE_URL || 'https://mohsenkashefi.live').replace(/\/$/, '');

const esc = s => String(s ?? '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
const sb = async path => {
  const ctl = new AbortController(), t = setTimeout(() => ctl.abort(), 8000);
  try {
    const r = await fetch(SB + path, { headers: { apikey: SBK, Authorization: 'Bearer ' + SBK }, signal: ctl.signal });
    if (!r.ok) throw new Error(`${path}: HTTP ${r.status}`);
    return await r.json();
  } finally { clearTimeout(t); }
};

// Same row → shape mapping as the page script (keep the two in sync).
const toWork = rows => rows.map(p => ({ t: p.title, g: p.tags || [], k: p.meta || '', d: p.description || '', s: (p.technologies || []).join(' · '), ...(p.live_url || p.github_url ? { u: p.live_url || p.github_url } : {}), h: p.accent || '#F3A847', ...(p.image_path ? { i: p.image_path } : {}) }));
const toStack = rows => { const m = new Map(); rows.forEach(r => { if (!m.has(r.category)) m.set(r.category, []); m.get(r.category).push(r.name); }); return [...m].map(([k, v]) => [k, v.join(' · ')]); };
const toSession = (rows, fallback) => {
  const ym = d => d ? d.slice(0, 7) : null, f = rows.find(r => r.kind === 'marker');
  return {
    first: f ? { start: ym(f.start_month), t: f.title, r: f.role || '', d: f.period_label || '', li: f.bullets || [] } : fallback.first,
    clips: rows.filter(r => r.kind === 'clip').map(r => ({ lane: r.lane, start: ym(r.start_month), end: ym(r.end_month), color: r.hollow ? null : r.color, hollow: r.hollow, t: r.title, r: r.role || '', d: r.period_label || '', li: r.bullets || [] })),
  };
};

const data = JSON.parse(await readFile(join(here, 'data.fallback.json'), 'utf8'));
const tries = [
  ['work', 'projects?select=*&is_featured=eq.true&tags=not.eq.%7B%7D&order=order_index', rows => rows.length && toWork(rows)],
  ['stack', 'skills?select=name,category,order_index&is_visible=eq.true&order=order_index', rows => rows.length && toStack(rows)],
  ['session', 'experience?select=*&order=order_index', rows => rows.some(r => r.kind === 'clip') && toSession(rows, data.session)],
];
for (const [key, path, map] of tries) {
  try { const v = map(await sb(path)); if (v) { data[key] = v; console.log(`supabase: ${key} ✓`); } else console.log(`supabase: ${key} empty, using built-in copy`); }
  catch (e) { console.log(`supabase: ${key} failed (${e.message}), using built-in copy`); }
}

let html = await readFile(join(here, 'index.html'), 'utf8');
const swap = (re, val) => { if (!re.test(html)) throw new Error('marker not found: ' + re); html = html.replace(re, () => val); };

// 1 · data blob the page script reads
swap(/<!--SITE:DATA-->[\s\S]*?<!--\/SITE:DATA-->/, '<!--SITE:DATA-->' + JSON.stringify(data).replace(/</g, '\\u003c') + '<!--/SITE:DATA-->');

// 2 · pre-rendered markup (same templates as the page script, so there is no flash when JS takes over)
const TAGN = { work: 'Work', personal: 'Personal', web: 'Web', mobile: 'Mobile', ai: 'AI' };
const link = w => /^https:\/\//.test(w.u || '') ? `<a href="${esc(w.u)}" target="_blank" rel="noopener">${esc(w.u.replace('https://', ''))} ↗</a>` : '';
swap(/<ol id="idxList"><\/ol>/, '<ol id="idxList">' + data.work.map((w, i) => `<li data-g="${esc(w.g.join(' '))}"><button class="nm" data-i="${i}"><span class="nmt">${esc(w.t)}</span><span class="tg">${w.g.map(x => esc(TAGN[x] || x)).join(' · ')}</span></button><div class="inl">${/^(media\/|https:\/\/)/.test(w.i || '') ? `<img class="av" src="${esc(w.i)}" alt="" width="76" height="76" loading="lazy" decoding="async" style="--ring:${/^#[0-9a-f]{3,8}$/i.test(w.h) ? w.h : '#F3A847'}">` : ''}<span>${esc(w.d)}</span><span class="stk">${esc(w.s)}</span>${link(w)}</div></li>`).join('') + '</ol>');
swap(/<ul id="layList"><\/ul>/, '<ul id="layList">' + data.stack.map(([n, t], i) => `<li><button data-i="${i}"><span class="k">${esc(n)}</span><span class="t">${esc(t)}</span></button></li>`).join('') + '</ul>');
const cur = data.session.clips.find(c => c.lane === 0 && !c.end) || data.session.clips.at(-1);
// the timeline lanes, pre-rendered with the same geometry as the page script, so every role is in the HTML
{ const S0 = 2015, NOW = new Date(), END = Math.max((2026 - S0) * 12 + 10, (NOW.getFullYear() - S0) * 12 + NOW.getMonth() + 1), mo = (y, m) => (y - S0) * 12 + m - 1, ym = v => { const [y, m] = v.split('-').map(Number); return mo(y, m); }, pct = v => v / END * 100;
  const C = data.session.clips.map(c => ({ ...c, s: ym(c.start), e: c.end ? ym(c.end) : END }));
  const LANES = ['Work', 'Intern · Freelance · Indie', 'Study', 'Projects'];
  const okHex = v => /^#[0-9a-f]{3,8}$/i.test(v || '') ? v : '#86A09E';
  swap(/<div id="sLanes"><\/div>/, '<div id="sLanes">' + LANES.map((n, l) => `<div class="lane"><div class="ln">${n}</div><div class="tr">${C.map((c, i) => c.lane === l ? `<button class="clip${c.hollow ? ' hollow' : ''}" data-i="${i}" style="--c:${okHex(c.color)};left:${pct(c.s)}%;width:calc(${pct(c.e - c.s)}% - 4px)" title="${esc(c.t)} · ${esc(c.d)}">${esc(c.t)}</button>` : '').join('')}</div></div>`).join('') + '</div>'); }
swap(/<div class="det" id="sDet" aria-live="polite"><\/div>/, `<div class="det" id="sDet" aria-live="polite"><div><h3>${esc(cur.t)}</h3><p class="m">${esc(cur.r)}<br>${esc(cur.d)}</p></div><ul>${cur.li.map(x => `<li>${esc(x)}</li>`).join('')}</ul></div>`);

// 3 · absolute URLs for canonical / social cards when the site URL is known
if (SITE) {
  swap(/<!--SEO:CANONICAL-->/, `<link rel="canonical" href="${SITE}/">\n<meta property="og:url" content="${SITE}/">`);
  html = html.replace(/content="\/og\.jpg"/g, `content="${SITE}/og.jpg"`).replace(/"\/media\//g, `"${SITE}/media/`);
} else swap(/<!--SEO:CANONICAL-->\n?/, '');

// structured data (schema.org): the person, the site, the projects and the single, with absolute URLs
{ const abs = p => /^https?:/.test(p || '') ? p : `${SITE}/${String(p || '').replace(/^\//, '')}`;
  const person = { '@type': 'Person', '@id': `${SITE}/#person`, name: 'Mohsen Kashefi', url: `${SITE}/`, image: abs('media/portrait.jpg'),
    jobTitle: 'Software Engineer', description: 'Software engineer and full-stack developer for web, mobile and AI in Brescia, Italy. Also a musician.',
    email: 'mailto:MohsenKashefi2016@yahoo.com', telephone: '+39 351 380 7875',
    address: { '@type': 'PostalAddress', addressLocality: 'Brescia', addressCountry: 'IT' },
    worksFor: { '@type': 'Organization', name: 'KTS Finance', url: 'https://www.ktsfinance.com' },
    alumniOf: [{ '@type': 'CollegeOrUniversity', name: 'Semnan University' }, { '@type': 'CollegeOrUniversity', name: 'University of Genoa' }],
    knowsAbout: [...new Set(data.stack.flatMap(([, t]) => t.split(' · ')))],
    sameAs: ['https://www.linkedin.com/in/mohsen-kashefi-825b7b18a/', 'https://github.com/MohsenKashefi', 'https://soundcloud.com/mohsen-kashefi'] };
  const graph = [
    { '@type': 'WebSite', '@id': `${SITE}/#website`, url: `${SITE}/`, name: 'Mohsen Kashefi', inLanguage: 'en', publisher: { '@id': `${SITE}/#person` } },
    { '@type': 'ProfilePage', '@id': `${SITE}/#profile`, url: `${SITE}/`, name: 'Mohsen Kashefi · Software Engineer & Artist', isPartOf: { '@id': `${SITE}/#website` }, mainEntity: { '@id': `${SITE}/#person` }, dateModified: new Date().toISOString().slice(0, 10) },
    person,
    { '@type': 'ItemList', name: 'Projects by Mohsen Kashefi', itemListElement: data.work.map((w, i) => ({ '@type': 'ListItem', position: i + 1,
      item: { '@type': 'CreativeWork', name: w.t, description: w.d, keywords: w.s, creator: { '@id': `${SITE}/#person` }, ...(w.i ? { image: abs(w.i) } : {}), ...(/^https:/.test(w.u || '') ? { url: w.u } : {}) } })) },
    { '@type': 'MusicRecording', name: 'Naboodi', byArtist: { '@id': `${SITE}/#person` }, url: 'https://soundcloud.com/mohsen-kashefi/naboodi', image: abs('media/naboodi.jpg') } ];
  swap(/<!--SEO:JSONLD-->/, `<script type="application/ld+json">${JSON.stringify({ '@context': 'https://schema.org', '@graph': graph }).replace(/</g, '\\u003c')}</script>`); }

// 4 · Content-Security-Policy: only this page's own inline script (by hash), our media, Google Fonts,
//     Supabase (content) and the analytics endpoint. frame-ancestors is sent as a header (render.yaml).
const hashes = [...html.matchAll(/<script>([\s\S]*?)<\/script>/g)].map(m => `'sha256-${createHash('sha256').update(m[1]).digest('base64')}'`);
const csp = [
  "default-src 'self'",
  `script-src 'self' ${hashes.join(' ')}`,
  "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com",
  "font-src https://fonts.gstatic.com",
  "img-src 'self' data: https://ltzpgwdxosnitvojnbth.supabase.co",
  "media-src 'self'",
  "connect-src 'self' https://ltzpgwdxosnitvojnbth.supabase.co",
  "object-src 'none'", "base-uri 'self'", "form-action 'self'", "upgrade-insecure-requests",
].join('; ');
swap(/<meta charset="utf-8">/, `<meta charset="utf-8">\n<meta http-equiv="Content-Security-Policy" content="${csp}">`);
console.log(`csp: ${hashes.length} inline script hash(es)`);

await rm(out, { recursive: true, force: true });
await mkdir(out, { recursive: true });
await writeFile(join(out, 'index.html'), html);
for (const f of ['media', 'favicon.svg', 'apple-touch-icon.png', 'og.jpg']) await cp(join(here, f), join(out, f), { recursive: true });
await writeFile(join(out, 'site.webmanifest'), JSON.stringify({ name: 'Mohsen Kashefi', short_name: 'Mohsen', description: 'Software engineer and artist', start_url: '/', display: 'standalone', background_color: '#0A1214', theme_color: '#0A1214',
  icons: [{ src: '/apple-touch-icon.png', sizes: '180x180', type: 'image/png' }, { src: '/favicon.svg', sizes: 'any', type: 'image/svg+xml' }] }, null, 1));
await writeFile(join(out, 'robots.txt'), `User-agent: *\nAllow: /\n${SITE ? `Sitemap: ${SITE}/sitemap.xml\n` : ''}`);
if (SITE) await writeFile(join(out, 'sitemap.xml'), `<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">\n  <url><loc>${SITE}/</loc><lastmod>${new Date().toISOString().slice(0, 10)}</lastmod><image:image><image:loc>${SITE}/media/portrait.jpg</image:loc></image:image><image:image><image:loc>${SITE}/og.jpg</image:loc></image:image></url>\n</urlset>\n`);
console.log(`built dist/ ${SITE ? 'for ' + SITE : '(no SITE_URL: canonical and sitemap skipped)'}`);
