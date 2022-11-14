with source as (

    select * from {{ source('coffee_shop', 'orders') }}

),

renamed as (

    select
        --IDs
        id as order_id,
        customer_id,

        --Context
        address,
        state,
        total,
        zip,

        --Dates
        created_at,

        --Booleans
        row_number() over (partition by customer_id order by created_at) = 1 as is_first_order

    from source

)

select * from renamed