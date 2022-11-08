{% set payment_methods = get_column_values('payment_method', ref('raw_payments')) %}

select
    {% for method in payment_methods %}
    sum(case when method = '{{payment_methods}}' then amount end) as {{method}}_amount
    {% if not loop.last %},{% endif %}
    {% endfor %}
from {{ ref('raw_payments') }}