-- Redesign, part 1: additive schema + experience timeline (safe while the Flutter site is live)
begin;
alter table public.projects add column if not exists tags text[] not null default '{}', add column if not exists meta text, add column if not exists accent text;
alter table public.skills add column if not exists is_visible boolean not null default true;
create table if not exists public.experience (
  id bigserial primary key,
  kind text not null default 'clip' check (kind in ('clip','marker')),
  lane smallint not null default 0,
  title text not null,
  role text,
  period_label text,
  start_month date not null,
  end_month date,
  color text,
  hollow boolean not null default false,
  bullets text[] not null default '{}',
  order_index integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
alter table public.experience enable row level security;
drop policy if exists "Allow public read for experience" on public.experience;
create policy "Allow public read for experience" on public.experience for select to anon, authenticated using (true);
drop policy if exists "Allow authenticated full access experience" on public.experience;
create policy "Allow authenticated full access experience" on public.experience for all to authenticated using (true) with check (true);
delete from public.experience;
insert into public.experience (kind, lane, title, role, period_label, start_month, color, bullets, order_index) values ('marker', 0, 'First line of code', 'Java · High school', '2015', '2015-09-01', '#F3A847', ARRAY['Started programming in Java in high school.']::text[], 0);
insert into public.experience (kind, lane, title, role, period_label, start_month, end_month, color, hollow, bullets, order_index) values ('clip', 0, 'Omega', 'Flutter Developer', 'May 2022 – Nov 2023 · Tehran', '2022-05-01', '2023-11-01', '#F3A847', false, ARRAY['Core features of Sahand, a ride-hailing app with 10,000+ downloads.','5+ mobile apps for 10,000+ users, with maps, live tracking and push notifications.','Laravel APIs and MySQL queries made 25% faster.']::text[], 1);
insert into public.experience (kind, lane, title, role, period_label, start_month, end_month, color, hollow, bullets, order_index) values ('clip', 0, 'Relocation', 'Career break', 'Dec 2023 – Oct 2024 · Genoa', '2023-12-01', '2024-10-01', NULL, true, ARRAY['Moved to Italy to start an M.Sc. in Robotics Engineering.']::text[], 2);
insert into public.experience (kind, lane, title, role, period_label, start_month, end_month, color, hollow, bullets, order_index) values ('clip', 0, 'Intelligent Innovations Lab', 'Flutter Developer', 'Nov 2024 – Apr 2025 · Remote, Canada', '2024-11-01', '2025-04-01', '#F3A847', false, ARRAY['Apps 40% more responsive through layout and state work.','35% less duplicated code with reusable UI components.','Releases 30% more reliable with Docker and GitHub Actions.']::text[], 3);
insert into public.experience (kind, lane, title, role, period_label, start_month, end_month, color, hollow, bullets, order_index) values ('clip', 0, 'KTS Finance', 'Full-Stack Developer', 'Jan 2026 – now · Brescia', '2026-01-01', NULL, '#F3A847', false, ARRAY['Ownership of 7 company systems in under 10 months.','A sales CRM with 190+ APIs, a web and mobile platform, two sales websites, a training academy and an AI assistant.','6+ services shipped with Docker and GitHub Actions.']::text[], 4);
insert into public.experience (kind, lane, title, role, period_label, start_month, end_month, color, hollow, bullets, order_index) values ('clip', 1, 'Freelance', 'Full-Stack Developer', 'Dec 2020 – Sep 2022 · Remote', '2020-12-01', '2022-09-01', '#72C6BE', false, ARRAY['4 full-stack apps for clients with 500+ active users.','Each project owned from requirements to launch and support.']::text[], 5);
insert into public.experience (kind, lane, title, role, period_label, start_month, end_month, color, hollow, bullets, order_index) values ('clip', 1, 'Independent', 'Independent Developer', 'May – Dec 2025 · Remote', '2025-05-01', '2025-12-01', '#72C6BE', false, ARRAY['Built and published Foody AI, CodeSnack and Password Checker Pro.']::text[], 6);
insert into public.experience (kind, lane, title, role, period_label, start_month, end_month, color, hollow, bullets, order_index) values ('clip', 2, 'B.Sc. Computer Engineering', 'Semnan University', '2018 – 2022 · Iran', '2018-09-01', '2022-07-01', '#B9C7C4', false, ARRAY['C++ Teaching Assistant for 50+ students.']::text[], 7);
insert into public.experience (kind, lane, title, role, period_label, start_month, end_month, color, hollow, bullets, order_index) values ('clip', 2, 'M.Sc. Robotics Engineering', 'University of Genoa', '2023 – now · Italy', '2023-09-01', NULL, '#B9C7C4', false, ARRAY['Degree in progress.']::text[], 8);
insert into public.experience (kind, lane, title, role, period_label, start_month, end_month, color, hollow, bullets, order_index) values ('clip', 3, 'WIB', 'Who Is Better?', '2021 · Personal', '2021-01-01', '2021-12-01', '#E3957E', false, ARRAY['Flutter and Node.js quiz game with 40 levels and a leaderboard.']::text[], 9);
insert into public.experience (kind, lane, title, role, period_label, start_month, end_month, color, hollow, bullets, order_index) values ('clip', 3, 'Password Checker Pro', 'Open source', '2025 · pub.dev', '2025-01-01', '2025-06-01', '#E3957E', false, ARRAY['Flutter package with 6 widgets and 7 languages.','323+ tests, 92% coverage.']::text[], 10);
insert into public.experience (kind, lane, title, role, period_label, start_month, end_month, color, hollow, bullets, order_index) values ('clip', 3, 'Foody AI · CodeSnack', 'Personal', '2025 – now', '2025-07-01', NULL, '#E3957E', false, ARRAY['Foody AI: AI nutrition app with Flutter, Gemini and 5 AWS Lambdas.','CodeSnack: Kotlin app with AI coding tips and a 9-language playground.']::text[], 11);
insert into public.experience (kind, lane, title, role, period_label, start_month, end_month, color, hollow, bullets, order_index) values ('clip', 0, 'Teaching Assistant', 'C++ · Semnan University', 'May – Dec 2020', '2020-05-01', '2020-12-01', '#F3A847', false, ARRAY['Helped students with C++ assignments, debugging and problem-solving.','Designed and reviewed practice questions, exercises and learning materials.']::text[], 12);
insert into public.experience (kind, lane, title, role, period_label, start_month, end_month, color, hollow, bullets, order_index) values ('clip', 1, 'Flutter internship', 'Nahira', 'Jun – Oct 2020 · Remote', '2020-06-01', '2020-10-01', '#72C6BE', false, ARRAY['Cross-platform mobile apps with Flutter and Dart.','Built interfaces from Figma designs and integrated features with GraphQL.']::text[], 13);
commit;
