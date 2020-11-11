select * 

from {{ source('ticket_tailor', 'orders') }}