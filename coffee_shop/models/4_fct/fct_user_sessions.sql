with user_sessions as (
  select * from `aec-students.dbt_grant.int_user_sessions`),

session_extrema as (
  select
    visitor_session_id,
    min(page_view_timestamp) as session_start_time,
    max(page_view_timestamp) as session_end_time,
    count(distinct page_view_id) as count_of_page_views
  from user_sessions
  group by 1
), 

sessions_with_purchases as (
  select
    distinct visitor_session_id,
    case when page = 'checkout' then true else false end as made_purchase
  from user_sessions
),

final as (
  select
    user_sessions.customer_id,
    user_sessions.visitor_id,
    user_sessions.device_type,
    user_sessions.visitor_session_id,
    session_extrema.session_start_time,
    session_extrema.session_end_time,
    timestamp_diff(session_end_time, session_start_time, minute) as session_length,
    sessions_with_purchases.made_purchase
  from user_sessions
  left join session_extrema using (visitor_session_id)
  left join sessions_with_purchases using (visitor_session_id)
)

select * from final