with source as (

    select * from {{ source('web_tracking', 'pageviews') }}

),

renamed as (

    select
        id as page_view_id,
        visitor_id,
        device_type,
        timestamp as page_view_timestamp,
        page,
        customer_id

    from source

)

select * from renamed