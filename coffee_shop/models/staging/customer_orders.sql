{{ config(materialized='view') }}

with customers as (
  select
    id as customer_id,
    name,
    email
  from {{ source('coffee_shop', 'customers') }}
  --from `analytics-engineers-club.coffee_shop.customers`
),

orders as (
  select
    customer_id,
    min(created_at) as first_order_at,
    count(distinct created_at) as orders
  from {{ source('coffee_shop', 'orders') }}
  --from `analytics-engineers-club.coffee_shop.orders`
  group by 1 
),

final as (
  select 
    customers.customer_id,
    customers.name,
    customers.email,
    orders.first_order_at,
    orders.orders
  from customers
  left join orders using (customer_id)
)

select *
from final