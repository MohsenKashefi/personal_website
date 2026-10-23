-- put EMKAN (after Sahand) and SongBuddy (last) on the website's project list
begin;
update public.projects set order_index = order_index + 1 where meta is not null and order_index >= 7;
update public.projects set
  is_featured = true, tags = array['work','mobile'], meta = 'Tehran Municipality', accent = '#84CC16', order_index = 7,
  description = 'A super app for Tehran Municipality employees, with employee management and services in one place.',
  technologies = array['Flutter','REST API'], live_url = null, image_path = 'media/p/emkan.jpg', category = 'Work', updated_at = now()
where title = 'EMKAN';
update public.projects set
  is_featured = true, tags = array['personal','mobile'], meta = 'Personal · Open source', accent = '#D946EF',
  order_index = (select max(order_index) + 1 from public.projects where meta is not null),
  description = 'A Flutter music companion for streaming and managing playlists.',
  technologies = array['Flutter','Node.js','MongoDB'], live_url = null, github_url = 'https://github.com/MohsenKashefi/SongBuddy',
  image_path = 'media/p/songbuddy.jpg', category = 'Personal', updated_at = now()
where title = 'SongBuddy';
commit;
