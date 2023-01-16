-- query 1
SELECT s.STORE_ID,s.TOTAL_SALE,d.MM,d.YYYY 
from warehouse.sales s,warehouse.dates d
where  s.TIME_ID=d.TIME_ID AND d.MM='September' AND d.YYYY=2017
ORDER by TOTAL_SALE DESC LIMIT 3;

-- query 2
 select s.SUPPLIER_ID, SUM(sa.TOTAL_SALE) as Total_sale,d.weekday
 from warehouse.suppliers s, warehouse.sales sa,warehouse.dates d
 where d.weekday='Saturday' OR d.weekday='Sunday' and sa.SUPPLIER_ID = s.SUPPLIER_ID 
 group by SUPPLIER_ID
 order by Total_sale limit 10;

 -- query 3
 select p.PRODUCT_ID,p.PRODUCT_NAME,s.SUPPLIER_ID,s.SUPPLIER_NAME,d.QTR as Quarterly, d.MM as Monthly, sum(sa.TOTAL_SALE) as Total_sale
from warehouse.sales sa, warehouse.suppliers s, warehouse.products p, warehouse.dates d
where p.PRODUCT_ID = sa.PRODUCT_ID and sa.SUPPLIER_ID = s.SUPPLIER_ID and sa.TIME_ID = d.TIME_ID
group by PRODUCT_ID, SUPPLIER_ID, Monthly, Quarterly 
order by PRODUCT_ID;

-- query 4
select s.STORE_ID,s.STORE_NAME ,p.PRODUCT_ID,p.PRODUCT_NAME, SUM(sa.TOTAL_SALE) as Total_sale
from warehouse.products p, warehouse.sales sa, warehouse.stores s
where sa.STORE_ID = s.STORE_ID and sa.PRODUCT_ID = p.PRODUCT_ID
group by STORE_ID, PRODUCT_ID
order by STORE_ID, PRODUCT_ID;

-- query 5
SELECT st.STORE_NAME,
       Sum(CASE WHEN d.QTR = 1 THEN TOTAL_SALE ELSE 0 end) AS "Q1",
       Sum(CASE WHEN d.QTR = 2 THEN TOTAL_SALE ELSE 0 end) AS "Q2",
       Sum(CASE WHEN d.QTR = 3 THEN TOTAL_SALE ELSE 0 end) AS "Q3",
       Sum(CASE WHEN d.QTR = 4 THEN TOTAL_SALE ELSE 0 end) AS "Q4"
FROM   sales s,stores st,dates d
WHERE  st.STORE_ID=s.STORE_ID and d.TIME_ID=s.TIME_ID and d.YYYY = 2017
GROUP  BY STORE_NAME;

-- query 6
select p.PRODUCT_ID,p.PRODUCT_NAME, d.WEEKDAY, sum(sa.TOTAL_SALE) as Sale
from warehouse.products p, warehouse.dates d , warehouse.sales sa
where d.WEEKDAY in ("Sunday", "Saturday" )
and p.PRODUCT_ID = sa.PRODUCT_ID
and d.TIME_ID = sa.TIME_ID 
group by PRODUCT_ID
order by sale desc
limit 5;

-- query 7
SELECT store_ID,supplier_ID,product_ID, sum(s.TOTAL_SALE)
FROM sales s
GROUP BY store_ID,supplier_ID,product_ID WITH ROLLUP;
-- Roll up from highly detailed data of store,supplier and product to less detail on basis of total sale
-- Rollup is used when we have to go from highly detailed data towards less detail. In our case rollup gives the total sale 
-- of a product by a single supplier in a specific store. 

-- query 8
-- -- first half(1) and second half (2)

select p.PRODUCT_ID, d.YYYY,  floor(d.QTR / 3) + 1 as half,  sum(sa.TOTAL_SALE) as sale
from warehouse.products p, warehouse.dates d, warehouse.sales sa
where p.PRODUCT_ID = sa.PRODUCT_ID
and d.TIME_ID = sa.TIME_ID
GROUP BY PRODUCT_ID,  (d.YYYY) + 0.1 * half;

-- query 9
SELECT product_name,COUNT(product_name)
FROM warehouse.products
GROUP BY product_name
HAVING COUNT(product_name) > 1;
-- Multiple products exists against a single ID i.e tomatoes 
SELECT *
FROM   metro.products
WHERE  product_name = 'Tomatoes';
-- on further checking it was found that tomatoes have multiple product ids, supplier ids each with different price which causes anamoly


-- query 10
drop view if exists STOREANALYSIS_MV;

CREATE view STOREANALYSIS_MV as
SELECT s.STORE_ID,s.STORE_NAME,p.PRODUCT_ID,p.PRODUCT_NAME,SUM(sa.TOTAL_SALE) as store_total
from warehouse.stores s, warehouse.sales sa, warehouse.products p
where
s.store_id = sa.store_id and
p.product_id = sa.product_id
GROUP by s.STORE_ID, p.PRODUCT_ID
ORDER by STORE_NAME, PRODUCT_NAME;
 
select * from STOREANALYSIS_MV;
-- Materialised view helps in scenario when data required is accessed using alot of joins which makes the query expensive. In our scenario, 
-- STOREANALYSIS_MV makes it easier to check store wise product sales without requiring any complex joins.
