select
    sum(case when payment_method  = 'credit_card' then amount end) as credit_card_amount,
    sum(case when payment_method = 'coupon' then amount end) as coupon_amount,
    sum(case when payment_method = 'bank_transfer' then amount end) as bank_transfer_amount,
    sum(case when payment_method = 'gift_card' then amount end) as gift_card_amount
from {{ref('raw_payments')}}