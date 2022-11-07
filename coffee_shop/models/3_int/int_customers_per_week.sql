with all_weeks as (
    select * from {{ ref('all_weeks') }}
),

customer_orders as (
    select * from {{ ref('stg_coffeeshop__orders')}}
),

customer_weekly_orders as (
    select
        customer_id,
        date_trunc(created_at, week) as date_week,
        sum(total) as total_revenue
    from customer_orders
    group by 1, 2
),

--find the first week so we can only look at weeks onwarads for each
customer_first_week as (
    select
        customer_id,
        min(date_Week) as first_week
    from customer_weekly_orders
    group by 1
),

-- create one record per week since a customer first spent money
spined as (
    select
        customer_first_week.customer_id,
        customer_first_week.first_week,
        all_weeks.date_week,
        date_diff(
            cast(all_weeks.date_week as datetime),
            cast(customer_first_week.first_week as datetime),
            week) as week_number
    from all_weeks
    inner join customer_first_week on all_weeks.date_Week >= customer_first_week.first_week
),

final as (
    select
        spined.customer_id,
        spined.first_week,
        spined.week_number,
        spined.date_week,
        coalesce(customer_weekly_orders.total_revenue, 0) as weekly_revenue,
        sum(coalesce(customer_weekly_orders.total_revenue, 0)) 
            over (partition by spined.customer_id order by spined.week_number
                rows between unbounded preceding and current row
            ) as cumulative_revenue
    from spined
    left join customer_weekly_orders
        on spined.customer_id = customer_weekly_orders.customer_id
        and spined.date_week = customer_weekly_orders.date_week
)

select * from final