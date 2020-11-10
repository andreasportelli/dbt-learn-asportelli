select 

    orderid as order_id,
    paymentmethod as payment_method,
    status,
    amount,
    created

from {{ source('stripe', 'payment') }}

