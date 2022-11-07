with page_views as (
    select * from {{ref('stg_web_tracking__page_views')}}
),

user_stitching as (
    select
        customer_id,
        array_agg(distinct visitor_id) as list_of_visitor_ids,
    from page_views
    group by 1
),

identifiable_customers as (
  select
    user_stitching.customer_id,
    user_stitching.list_of_visitor_ids[offset(0)] as visitor_id, --calling the first visitor_id as the consolidated visitor_id
    page_views.device_type,
    page_views.page_view_timestamp,
    page_views.page,
    page_views.page_view_id
  from user_stitching
  left join page_views using (customer_id)
),

unidentifiable_customers as (
  select *
  from page_views
  where customer_id is null
),

final as (
  select * from identifiable_customers
  union all
  select * from unidentifiable_customers
)

select * from final