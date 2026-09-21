--A Explore Data
Select * from production.brands
Select * from production.categories
Select * from production.products
Select * from production.stocks
Select * from sales.customers
Select * from sales.order_items
Select * from sales.orders
Select * from sales.staffs
Select * from sales.stores
-- 1) Which bike is most expensive? What could be the motive behind pricing
--    this bike at the high price?
select top 1 
        c.*,p.*
from production.products p join production.categories c
on p.category_id=c.category_id
order by p.list_price desc
-- Becouse its Road Bike and the latest year model

-- 2) How many total customers does BikeStore have? Would you consider people
--    with order status 3 as customers - substantiate your answer.
select 
        count(c.customer_id) total_customers
from sales.customers c join sales.orders o
on c.customer_id = o.customer_id
where o.order_status != 3
-- We would not consider them as custmers Becouse there orders has rejected

-- 3) How many stores does BikeStore have?
select count(*) total_stores
from sales.stores


-- 4) What is the total price spent per order?
select
        order_id,
        sum(list_price * quantity * (1 - discount))  total_price
from sales.order_items
group by order_id



-- 5) What's the sales/revenue per store?
select
        s.store_id,
        s.store_name,
        sum(oi.list_price * oi.quantity * (1 - oi.discount))  store_revenue
from sales.orders o
join sales.order_items oi on oi.order_id = o.order_id
join sales.stores s on s.store_id = o.store_id
group by s.store_id, s.store_name
order by store_revenue desc


-- 6) Which category is most sold? (by quantity sold)
select top 1
        c.category_name,
        sum(oi.quantity) total_quantity_sold
from sales.order_items oi
join production.products p on p.product_id = oi.product_id
join production.categories c on c.category_id = p.category_id
group by c.category_name
order by total_quantity_sold desc


-- 7) Which category rejected more orders? (order_status = 3)
select top 1
        c.category_name,
        count(distinct o.order_id)  rejected_orders
FROM sales.orders o
join sales.order_items oi on oi.order_id = o.order_id
join production.products p on p.product_id = oi.product_id
join production.categories c on c.category_id = p.category_id
where o.order_status = 3
group by c.category_name
order by rejected_orders desc


-- 8) Which bike is the least sold? 
-- this are the list sold but not the never sold biks   
Select 
        p.product_name,
        sum(oi.quantity)  total_quantity_sold
from sales.order_items oi
join production.products p on p.product_id = oi.product_id 
group by p.product_name
having sum(oi.quantity) = 1
order by total_quantity_sold asc



-- 9) What's the full name of a customer with ID 259?
select
    customer_id,
    first_name + ' ' + last_name full_name
from sales.customers
where customer_id = 259


-- 10) What did the customer on question 9 buy and when? What's the status of
--     this order?
select
        o.order_id,
        p.product_name,
        oi.quantity,
        o.order_date
from sales.orders o
join sales.order_items oi on oi.order_id = o.order_id
join production.products p on p.product_id = oi.product_id
where o.customer_id = 259


-- 11) Which staff processed the order of customer 259? And from which store?
select
        o.order_id,
        st.first_name + ' ' + st.last_name staff_name,
        sr.store_name
from sales.orders o
join sales.staffs st on st.staff_id = o.staff_id
join sales.stores sr on sr.store_id = o.store_id
where o.customer_id = 259


-- 12) How many staff does BikeStore have? Who seems to be the lead staff?
select count(*)  total_staff
from sales.staffs

-- The "lead" staff is the one with no manager_id

select
        staff_id,
        first_name + ' ' + last_name  full_name
from sales.staffs
where manager_id is null


-- 13) Which brand is the most liked? 
select top 1
    b.brand_name,
    sum(oi.quantity)  total_quantity_sold
from sales.order_items oi
join production.products p on p.product_id = oi.product_id
join production.brands b on b.brand_id = p.brand_id
group by b.brand_name
order by total_quantity_sold desc


-- 14) How many categories does BikeStore have?
select count(*)  total_categories
from production.categories

--     which one is the least liked?
select top 1
        c.category_name,
        isnull(SUM(oi.quantity), 0)  total_quantity_sold
from production.categories c
left join production.products p on p.category_id = c.category_id
left join sales.order_items oi on oi.product_id = p.product_id
group by c.category_name
order by total_quantity_sold asc


-- 15) Which store still has more products (in stock) of the most liked brand?
select top 1
        s.store_name,
        sum(st.quantity)  stock_quantity
from production.stocks st
join production.products p on p.product_id = st.product_id
join production.brands b on b.brand_id = p.brand_id
join sales.stores s on s.store_id = st.store_id
where b.brand_name = 'Electra'
group by s.store_name
order by stock_quantity desc


-- 16) Which state is doing better in terms of sales? 
select top 1
        s.state,
        sum(oi.list_price * oi.quantity * (1 - oi.discount))  total_sales
from sales.orders o
join sales.order_items oi on oi.order_id = o.order_id
join sales.stores s on s.store_id = o.store_id
group by s.state
order by total_sales desc


-- 17) What's the discounted price of product id 259?
select
        oi.order_id,
        p.product_name,
        oi.list_price,
        oi.discount,
        oi.list_price * (1 - oi.discount)  discounted_price
from sales.order_items oi
join production.products p on p.product_id = oi.product_id
where oi.product_id = 259


-- 18) What's the product name, quantity (in stock), price, category, model
--     year and brand name of product number 44?
select
    p.product_name,
    SUM(st.quantity)  total_quantity_in_stock,
    p.list_price,
    c.category_name,
    p.model_year,
    b.brand_name
from production.products p
join production.categories c on c.category_id = p.category_id
join production.brands b on b.brand_id = p.brand_id
left join production.stocks st on st.product_id = p.product_id
where p.product_id = 44
group by p.product_name, p.list_price, c.category_name, p.model_year, b.brand_name


-- 19) What's the zip code of CA?
select distinct zip_code
from sales.stores
where state = 'CA'

-- 20) How many states does BikeStore operate in? (based on store locations)
select count(distinct state)  states_operating_in
from sales.stores


-- 21) How many bikes under the children category were sold in the last 8
--     months? (relative to the most recent order date in the data)
select
        sum(oi.quantity)  children_last_8_months
from sales.orders o
join sales.order_items oi on oi.order_id = o.order_id
join production.products p on p.product_id = oi.product_id
join production.categories c on c.category_id = p.category_id
where c.category_name = 'Children Bicycles'
  and o.order_date >= dateadd(month, -8, (select max(order_date) from sales.orders))


-- 22) What's the shipped date for the order from customer 523?
select
        order_id,
        customer_id,
        shipped_date
from sales.orders
where customer_id = 523


-- 23) How many orders are still pending?
select count(*)  pending_orders
from sales.orders
where order_status = 1


-- 24) What's the name of category and brand does "Electra white water 3i -
--     2018" fall under?
select
        p.product_name,
        c.category_name,
        b.brand_name
from production.products p
join production.categories c on c.category_id = p.category_id
join production.brands b on b.brand_id = p.brand_id
where p.product_name = 'Electra White Water 3i - 2018'

