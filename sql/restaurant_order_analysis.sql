SELECT *
FROM menu_items;

SELECT * 
FROM order_details;

-- Join Two Tables
SELECT *
FROM menu_items
JOIN order_details
	ON menu_item_id = item_id;


-- List top 10 most sold menu items along with categories
SELECT item_name, category, 
	   COUNT(item_id) AS order_count
FROM menu_items mi
JOIN order_details od
	ON mi.menu_item_id = od.item_id
GROUP BY item_name, category
ORDER BY order_count DESC
LIMIT 10;

-- List top 10 menu items that created the most total revenue 
SELECT item_name, category, SUM(price) AS total_revenue
FROM menu_items mi
JOIN order_details od
	ON mi.menu_item_id = od.item_id
GROUP BY item_name, category
ORDER BY total_revenue DESC
LIMIT 10;


-- Each category's total orders, total revenue, and average price
SELECT category, 
	   COUNT(od.item_id) AS total_orders,
       SUM(mi.price) AS total_revenue,
       AVG(mi.price) AS avg_price
FROM order_details od
JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY category;

-- Daily sales
SELECT od.order_date,
	   SUM(mi.price) as sales
FROM order_details od
JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY od.order_date
ORDER BY od.order_date;



-- How many orders had more than 12 items?
SELECT COUNT(*) 
FROM
	(SELECT order_id, COUNT(item_id) AS num_items
	FROM order_details
	GROUP BY order_id
	HAVING num_items > 12
	ORDER BY num_items) AS num_orders
;


-- Top 5 orders that spent the most money
SELECT order_id, SUM(price) as money_spend
FROM order_details od
JOIN menu_items mi
	ON mi.menu_item_id = od.item_id
GROUP BY order_id
ORDER BY money_spend DESC
LIMIT 5;


-- Detail of the highest spend order. What insights can you gather from the data?
SELECT *
FROM order_details od
JOIN menu_items mi
	ON mi.menu_item_id = od.item_id
WHERE order_id = 440
ORDER BY category, price;


-- Detail of the top 5 spend order
SELECT *
FROM order_details od
JOIN menu_items mi
	ON mi.menu_item_id = od.item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
ORDER BY order_id;


-- number of items of each category by the top 5 orders
SELECT order_id, category, COUNT(item_id) AS num_items
FROM order_details od
JOIN menu_items mi
	ON mi.menu_item_id = od.item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;


