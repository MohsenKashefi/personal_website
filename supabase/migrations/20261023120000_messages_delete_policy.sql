-- the dashboard now talks to Supabase as the signed-in admin (no service key), so the admin needs an explicit delete right on messages
drop policy if exists "Allow authenticated delete messages" on public.messages;
create policy "Allow authenticated delete messages" on public.messages for delete to authenticated using (true);
