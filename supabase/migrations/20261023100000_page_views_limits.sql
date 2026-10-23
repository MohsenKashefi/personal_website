-- page_views is written directly by the website with the public (anon) key.
-- Anon can only INSERT (RLS); these checks keep each row small and well-formed so the table can't be stuffed with junk.
-- NOT VALID: applies to new rows only, existing history is left untouched.
alter table public.page_views
  add constraint page_views_path_ok    check (char_length(page_path) <= 100 and page_path ~ '^/[a-z0-9/_-]*$') not valid,
  add constraint page_views_session_ok check (session_id is null or char_length(session_id) <= 64) not valid,
  add constraint page_views_ref_ok     check (referrer is null or char_length(referrer) <= 300) not valid,
  add constraint page_views_ua_ok      check (user_agent is null or char_length(user_agent) <= 400) not valid,
  add constraint page_views_device_ok  check (device_type is null or device_type in ('mobile','tablet','desktop')) not valid,
  add constraint page_views_country_ok check (country is null or char_length(country) <= 64) not valid;
