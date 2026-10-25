begin;
revoke all on public.hub_posts,public.hub_comments,public.hub_metrics,public.hub_profiles from anon;
alter policy hub_post_read on public.hub_posts to authenticated using(auth.uid() is not null);
alter policy hub_comment_read on public.hub_comments to authenticated using(auth.uid() is not null and exists(select 1 from public.hub_posts p where p.id=post_id));
alter policy hub_metrics_read on public.hub_metrics to authenticated using(auth.uid() is not null);
commit;
select not has_table_privilege('anon','public.hub_posts','select') as anonymous_posts_blocked,not has_table_privilege('anon','public.hub_comments','select') as anonymous_comments_blocked,not has_table_privilege('anon','public.hub_metrics','select') as anonymous_metrics_blocked;