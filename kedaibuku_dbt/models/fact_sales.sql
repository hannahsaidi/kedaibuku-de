-- Grain: one order line
select
    o.order_id,
    d.date_key,
    c.customer_id,
    o.book_id,
    o.quantity,
    b.list_price_myr                                        as unit_price_myr,
    round((o.quantity * b.list_price_myr)::numeric, 2)      as revenue_myr
from {{ source('silver', 'orders') }} o
join {{ ref('dim_book') }} b on b.book_id = o.book_id
join {{ ref('dim_date') }} d on d.date_key = to_char(o.order_date, 'YYYYMMDD')::int
join {{ ref('dim_customer') }} c on c.customer_id = o.customer_id