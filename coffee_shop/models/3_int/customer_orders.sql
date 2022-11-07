{{ config(materialized='view') }}

with customers as (
  select * from {{ref('stg_coffeeshop__customers')}}
),

orders as (
  select
    customer_id,
    min(created_at) as first_order_at,
    count(distinct created_at) as orders
  from {{ref('stg_coffeeshop__orders')}}
  group by 1 
),

final as (
  select 
    customers.customer_id,
    customers.customer_name,
    customers.customer_email,
    orders.first_order_at,
    orders.orders
  from customers
  left join orders using (customer_id)
)

select *
from final