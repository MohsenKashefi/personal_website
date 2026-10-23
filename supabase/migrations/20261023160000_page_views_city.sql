-- city-level location for visits (from Vercel's IP geolocation; the IP itself is never stored)
alter table public.page_views add column if not exists city text, add column if not exists region text;
alter table public.page_views
  add constraint page_views_city_ok   check (city is null or char_length(city) <= 80) not valid,
  add constraint page_views_region_ok check (region is null or char_length(region) <= 80) not valid;
notify pgrst, 'reload schema';
