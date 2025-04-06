1----View the menu_items table 
SELECT * FROM
menu_items;
-- What were the least and most ordered items? What categories were they in?

2-- Most ordered item and category
SELECT m.item_name, COUNT(o.item_id) AS total_orders, m.category
FROM order_details o
JOIN menu_items m ON o.item_id = m.menu_item_id
GROUP BY m.item_name, m.category
ORDER BY total_orders DESC 
LIMIT 1;

3-- Least ordered item and category
SELECT m.item_name, COUNT(o.item_id) AS total_orders, m.category
FROM order_details o
JOIN menu_items m ON o.item_id = m.menu_item_id
GROUP BY m.item_name, m.category
ORDER BY total_orders ASC 
LIMIT 1;
4---which specific items were purchased
SELECT item_name, SUM(price)
FROM menu_items m JOIN order_details o
ON m.menu_item_id = o.item_id
GROUP BY item_name
ORDER BY SUM(price) DESC;

5-- Highest spend orders and items bought with spend details
SELECT order_id, item_name, SUM(price) AS spend_order
FROM menu_items m JOIN order_details o
ON m.menu_item_id = o.item_id
GROUP BY order_id,item_name
ORDER BY SUM(price) DESC
LIMIT 5;

6-- Were there certain times that had more or less orders?

SELECT EXTRACT(HOUR FROM o.order_time) AS order_hour, COUNT(DISTINCT o.order_id) AS total_orders
FROM order_details o
GROUP BY order_hour
ORDER BY total_orders DESC;

7-- Which cuisines should we focus on developing more menu items for based on the data?
SELECT m.category AS cuisine_type, SUM(price) AS total_revenue
FROM order_details o
JOIN menu_items m ON o.item_id = m.menu_item_id
GROUP BY m.category
ORDER BY total_revenue DESC 
LIMIT 3;
--Additional questions
8-- How many orders had more than 12 items?
SELECT COUNT(*) AS orders_with_more_than_12_items
FROM (
    SELECT order_id
    FROM order_details
    GROUP BY order_id
    HAVING COUNT(item_id) > 12
) AS subquery;

9.----How many Italian dishes are on the menu? 
SELECT COUNT(*) AS italian_dish_count
FROM menu_items
WHERE category = 'Italian';

10--What is the most expensive Italian dishes on the menu?
SELECT item_name, category, price
FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC
LIMIT 1;

11--How many dishes are in each category?
SELECT category, COUNT(*) AS dish_count
FROM menu_items
GROUP BY category;

12--What is the average dish price within each category?
SELECT category, AVG(price) AS average_price
FROM menu_items
GROUP BY category;
13--View the order_details table
SELECT * FROM order_details;
14--What is the date range of the order details table?
SELECT MIN(order_date) AS start_date, MAX(order_date) AS end_date
FROM order_details;
15--How many orders were made within this date range? 
SELECT COUNT(DISTINCT order_id) AS order_count
FROM order_details
WHERE order_date BETWEEN (SELECT MIN(order_date) 
FROM order_details) AND (SELECT MAX(order_date) FROM order_details);

16--How many items were ordered within this date range?
SELECT COUNT(*) AS total_items_ordered
FROM order_details
WHERE order_date BETWEEN (SELECT MIN(order_date) 
FROM order_details) AND (SELECT MAX(order_date) FROM order_details);

17--Which orders had the most number of items?
SELECT order_id, COUNT(*) AS item_count
FROM order_details
GROUP BY order_id
ORDER BY item_count DESC
LIMIT 1;

