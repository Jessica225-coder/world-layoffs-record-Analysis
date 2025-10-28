-- Ruff N Rumble
/* Ruff and Rumble
Analyzing Ruff and Rumble Sales analysis
*/


show variables like '%secure_file_priv%';
   

create database `Ruff N Rumble`;

use `Ruff N Rumble`;

Create table customer_table( 
customer_id varchar(200),
customer_name varchar(200),
gender varchar(200),
email varchar(200),
phone varchar(200),
state varchar(200),
address varchar(200), 
date_joined varchar(200));

LOad data infile "C:/ProgramData/MySQL/MySQL Server 9.3/Uploads/Tcustomers.csv"
into Table customer_table
Fields Terminated by ','
optionally enclosed by '"'
lines Terminated by '/n'
ignore 1 rows;

show variables like '%secure_file_priv%';

Create table product_table (
product_id varchar (200),
product_name varchar (200),
category varchar (200),
price  varchar (200),
stock_quantity  varchar (200),
size  varchar (200),
color varchar (200),
date_added  varchar (200));

LOad data infile "C:/ProgramData/MySQL/MySQL Server 9.3/Uploads/Tproducts.csv"
into Table product_table
Fields Terminated by ','
optionally enclosed by '"'
lines Terminated by '/n'
ignore 1 rows;

Create Table sales_Table (
sale_id varchar (200),
customer_id varchar (200),
staff_id varchar (200),
product_id varchar (200),
quantity varchar (200),
total_amount varchar (200),
payment_method varchar (200),
order_channel varchar (200),
order_state varchar (200),
order_date varchar (200));

LOad data infile "C:/ProgramData/MySQL/MySQL Server 9.3/Uploads/Tsales.csv"
into Table Sales_table
Fields Terminated by ','
optionally enclosed by '"'
lines Terminated by '/n'
ignore 1 rows;

Create Table Staff_Table (
staff_id varchar (200),
staff_name varchar (200),
gender varchar (200),
email varchar (200),
phone varchar (200),
position varchar (200),
salary varchar (200),
branch varchar (200),
date_hired varchar (200));

LOad data infile "C:/ProgramData/MySQL/MySQL Server 9.3/Uploads/Tstaff.csv"
into Table Staff_table
Fields Terminated by ','
optionally enclosed by '"'
lines Terminated by '\n'
ignore 1 rows;



select distinct (order_state)
from sales_table
order by 1;

(select sl.sale_id,sl.quantity,sl.total_amount,sl.payment_method,sl.order_state,sl.order_date, ct.customer_name,ct.gender,pt.category,pt.stock_quantity,pt.price,pt.size,pt.color,st.branch,pt.product_name
from sales_table  sl
left join customer_table  ct
on sl.customer_id =ct.customer_id
left join product_table  pt
on pt.product_id = sl.product_id
left join staff_table  st
on sl.staff_id = st.staff_id
);

select *
from order_table;

CREATE TEMPORARY TABLE ORDER_TABLE 

select sl.sale_id,sl.quantity,sl.total_amount,sl.payment_method,sl.order_state,sl.order_date, ct.customer_name,ct.gender,pt.category,pt.stock_quantity,pt.price,pt.size,pt.color,st.branch,pt.product_name
from sales_table sl
left join customer_table  ct
on sl.customer_id =ct.customer_id
left join product_table  pt
on pt.product_id = sl.product_id
left join staff_table  st
on sl.staff_id = st.staff_id;


-- TO DUPLICATE DATASET
SELECT *    FROM ORDER_TABLE;

CREATE TABLE D_ORDER_TABLE LIKE ORDER_TABLE;

SELECT * 
FROM D_ORDER_TABLE;

INSERT INTO D_ORDER_TABLE   
SELECT *
FROM ORDER_TABLE;

SELECT *
FROM  D_ORDER_TABLE;

-- MISSING VALUES IN DATASET

SELECT *
from  D_ORDER_TABLE;

select distinct  total_amount
from d_order_table
order by 1;

update d_order_table set  total_amount = NULL 
Where total_amount = '' or total_amount = "Error";


Alter Table d_order_table
modify column total_amount Float; 


select distinct total_amount, hex(total_amount)
From d_order_table
order by 1;

select quantity
from d_order_table
order by 1;


update d_order_table set  quantity = NULL 
Where quantity = '' or quantity = "Error";

select quantity
from d_order_table  order by 1;

Alter Table d_order_table
modify column quantity int; 

describe d_order_table;

Alter Table d_order_table
modify column price Float;

describe d_order_table;

select distinct *
from d_order_table
where total_amount is null or price is null or quantity is null;


update d_order_table
set quantity = total_amount / price
where quantity is null;


update d_order_table
set total_amount = quantity *  price
where total_amount is null;

----- we are deleting this because the quantity and total amount we are working with is not avaliable. we are working on sales analysis

delete
from d_order_table
where quantity is null and total_amount is null;


-- Total Amount made in sales
select distinct round(sum(price),2)
from d_order_table;


-- Quantity of items sold 
select quantity
from d_order_table;

-- Number of Customers
select distinct count(customer_name)
from d_order_table;

-- state with Hight Number of Order
select distinct order_state
from d_order_table
order by 1;

-- Branch with the Highest sales
select branch, count(total_amount) Amount
From d_order_table
group by branch
order by 1 desc;

-- Most Used payment method
select count(payment_method)  payment, payment_method
from d_order_table
group by payment_method;
