with customers as (

    select * from {{ ref('stg_customers') }}

),

stg_orders as (

    select * from {{ ref('stg_orders') }}

),

orders as (

    select * from {{ ref('orders') }}

),

customer_orders as (

    select
        so.customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(o.order_id) as number_of_orders,
        sum(o.amount) as lifetime_value

    from stg_orders so 
    join orders o on o.order_id=so.order_id 

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        customer_orders.lifetime_value,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders using (customer_id)

)

select * from final