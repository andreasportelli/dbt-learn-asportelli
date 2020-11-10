with payments as (

    select * from {{ ref('stg_payments') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

)


select 

    o.order_id, 
    o.customer_id, 
    p.amount, 
    p.payment_method, 
    p.status 

from payments p 
join orders o on o.order_id=p.order_id