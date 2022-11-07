with user_stitching as (
  select * from {{ref('int_user_stitching')}}
  ),

create_last_event_timestamp as (
  select
    user_stitching.*,
    lag(page_view_timestamp, 1) over (partition by visitor_id, device_type order by page_view_timestamp) as last_event
  from user_stitching
),

create_session_segments as (
  select 
    create_last_event_timestamp.*,
    case  
      when timestamp_diff(create_last_event_timestamp.page_view_timestamp, create_last_event_timestamp.last_event, minute) <= 30 
            or create_last_event_timestamp.last_event is null
      then 1
      else 0
      end as is_new_session,
    timestamp_diff(create_last_event_timestamp.page_view_timestamp, create_last_event_timestamp.last_event, minute) as event_diff
  from create_last_event_timestamp
),

final as (
  select
    *,
    sum(is_new_session) over (order by visitor_id) as visitor_session_id
  from create_session_segments
)

select * from final