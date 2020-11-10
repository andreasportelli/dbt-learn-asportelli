with payments as (

    select * from {{ ref('stg_payments') }}
    where status = 'success'

),

orders as (

    select * from {{ ref('stg_orders') }}

)

select 

    o.order_id, 
    o.customer_id, 
    sum(p.amount) as amount

from payments p 
join orders o on o.order_id=p.order_id
group by o.order_id, o.customer_id