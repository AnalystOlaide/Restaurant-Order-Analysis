
## 🍽 Restaurant Orders Analysis (SQL Project)

### 1. 📌 Project Title
Restaurant Orders Analysis

### 2. 📄 Project Overview
This project analyzes a fictitious restaurant's orders over a quarter, providing insights into food orders, customer behavior, and menu item performance. The restaurant serves international cuisine, and the analysis covers the date and time of each order, the items ordered, and their types, names, and prices. The goal is to help the restaurant optimize menu development, pricing strategies, and customer engagement.

### 3. ❓ Problem Statement
Restaurants often face challenges in understanding which items are popular, which time periods bring in the most orders, and which dishes drive the most revenue. This analysis will address these challenges by investigating the restaurant's order trends, spending patterns, and customer preferences based on the available data.

---

## 🗂 Data Source  
- **Source:** [Maven Analytics - SQL Challenge Dataset](https://www.mavenanalytics.io/)  
- **Tables Used:**  
  - `menu_items`: Contains details like item name, category, and price  
  - `order_details`: Tracks order ID, item ID, date, time, and quantity  

---

## 🧰 Tools Used  
- **Database:** PostgreSQL  
- **Techniques:**  
  - `JOIN`, `GROUP BY`, `ORDER BY`, `COUNT`, `SUM`, `AVG`, `LIMIT`, `EXTRACT`, subqueries, etc.  

---

## 📊 Recommended Analysis  
- What were the least and most ordered items? What categories were they in?  
- What do the highest spend orders look like? Which items did they buy and how much did they spend?  
- Were there certain times that had more or fewer orders?  
- Which cuisines should we focus on developing more menu items for based on the data?

### Additional Analysis:  
1. How many orders had more than 12 items?  
2. How many Italian dishes are on the menu?  
3. What is the most expensive Italian dish on the menu?  
4. How many dishes are in each category?  
5. What is the average dish price within each category?  
6. View the `order_details` table.  
7. What is the date range of the `order_details` table?

---

## 📊 Key Insights & SQL Queries  

### 🔍 1. What was the most ordered item and category?  
![Most Ordered Item](https://github.com/user-attachments/assets/0ffbb0de-3a2a-46e6-9adc-f24191c39d9b)

```sql
SELECT m.item_name, COUNT(o.item_id) AS total_orders, m.category
FROM order_details o
JOIN menu_items m ON o.item_id = m.menu_item_id
GROUP BY m.item_name, m.category
ORDER BY total_orders DESC 
LIMIT 1;
```
**Result:** Hamburger (American)

---

### 🔍 2. Least ordered item and category  
![Least Ordered Item](https://github.com/user-attachments/assets/54aace29-8f71-4d2c-b934-22ec03dba37b)

```sql
SELECT m.item_name, COUNT(o.item_id) AS total_orders, m.category
FROM order_details o
JOIN menu_items m ON o.item_id = m.menu_item_id
GROUP BY m.item_name, m.category
ORDER BY total_orders ASC 
LIMIT 1;
```
**Result:** Chicken Tacos (Mexican)

---

### 🔍 3. Total unique items purchased  
![Unique Items](https://github.com/user-attachments/assets/0548e298-6051-49b8-aee8-d34aa0619d97)

```sql
SELECT COUNT(DISTINCT item_name) 
FROM menu_items m
JOIN order_details o ON m.menu_item_id = o.item_id;
```
**Result:** 32 items

---

### 🔍 4. Highest spend orders  
![Highest Spend Orders](https://github.com/user-attachments/assets/9b397e22-1031-4b73-88c0-868e0f2e8b0f)

```sql
SELECT order_id, item_name, SUM(price) AS spend_order
FROM menu_items m 
JOIN order_details o ON m.menu_item_id = o.item_id
GROUP BY order_id, item_name
ORDER BY spend_order DESC
LIMIT 5;
```
**Top Spending Items:**  
- Meat Lasagna – $53.85  
- Korean Beef Bowl – $53.85  
- Chicken Parmesan – $53.85  
- Eggplant Parmesan – $50.85  

---

### 🔍 5. Peak order times  
![Peak Order Times](https://github.com/user-attachments/assets/bba58755-c4d2-4c41-a730-fca55f9d3fc3)

```sql
SELECT EXTRACT(HOUR FROM order_time) AS order_hour, COUNT(DISTINCT order_id) AS total_orders
FROM order_details
GROUP BY order_hour
ORDER BY total_orders DESC;
```
**Result:** Peak hours = 12:00, 18:00, 13:00

---

### 🔍 6. Best-selling cuisines (by revenue)  
![Top Cuisines](https://github.com/user-attachments/assets/2c6c3a29-361e-4381-8c73-a92591750b2d)

```sql
SELECT category, SUM(price) AS total_revenue
FROM menu_items m
JOIN order_details o ON m.menu_item_id = o.item_id
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 3;
```
**Top 3:** Italian, Asian, Mexican

---

### 🔍 7. Orders with more than 12 items  
![Orders > 12 Items](https://github.com/user-attachments/assets/4a766fdf-ea29-468c-b35b-fadd00cceffa)

```sql
SELECT COUNT(*) AS orders_with_more_than_12_items
FROM (
    SELECT order_id
    FROM order_details
    GROUP BY order_id
    HAVING COUNT(item_id) > 12
) sub;
```
**Result:** 20 orders

---

### 🔍 8. Number of Italian dishes on the menu  
![Italian Dishes](https://github.com/user-attachments/assets/991d7c61-80ef-4f7f-b351-deeb26b8ccec)

```sql
SELECT COUNT(*) 
FROM menu_items 
WHERE category = 'Italian';
```
**Result:** 9 dishes

---

### 🔍 9. Most expensive Italian dish  
![Most Expensive Italian Dish](https://github.com/user-attachments/assets/3ebb76eb-3599-417b-8ac3-f57f3813f020)

```sql
SELECT item_name, category, price
FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC
LIMIT 1;
```
**Result:** Shrimp Scampi

---

### 🔍 10. Dish count by category  
![Dish Count by Category](https://github.com/user-attachments/assets/c7dab7bf-d007-4764-ad6a-e3a32934f85c)

```sql
SELECT category, COUNT(*) AS dish_count
FROM menu_items
GROUP BY category;
```
- Italian: 9  
- Mexican: 9  
- Asian: 8  
- American: 6  

---

### 🔍 11. Average dish price per category  
![Average Price](https://github.com/user-attachments/assets/c0000265-acb1-4f37-a30c-145f8629dde3)

```sql
SELECT category, ROUND(AVG(price), 2) AS avg_price
FROM menu_items
GROUP BY category;
```
- Italian: $16.75  
- Asian: $13.48  
- American: $10.07  
- Mexican: ⚠️ *Possible data error – review pricing*

---

### 🔍 12. Order date range  
![Date Range](https://github.com/user-attachments/assets/e77bbb96-b4e0-4659-afd9-27327cd74061)

```sql
SELECT MIN(order_date) AS start_date, MAX(order_date) AS end_date
FROM order_details;
```
**Result:** Jan 1, 2023 – Mar 31, 2023

---

### 🔍 13. Total number of orders  
![Total Orders](https://github.com/user-attachments/assets/38e37622-aa7c-4822-9000-52455c8a8d7f)

```sql
SELECT COUNT(DISTINCT order_id) 
FROM order_details;
```
**Result:** 5,370 orders

---

### 🔍 14. Total number of items ordered  
![Items Ordered](https://github.com/user-attachments/assets/9fda3e8c-070a-4e5c-96b5-bcebe9cfe6e1)

```sql
SELECT COUNT(*) 
FROM order_details;
```
**Result:** 12,234 items

---

### 🔍 15. Order with the most items  
![Most Items Order](https://github.com/user-attachments/assets/7104ccf4-52f3-4d20-b702-bdb75081a27b)

```sql
SELECT order_id, COUNT(*) AS item_count
FROM order_details
GROUP BY order_id
ORDER BY item_count DESC
LIMIT 1;
```
**Result:** Order ID 2675

---



---

## 📌 Project Credits  
**Dataset:** [Maven Analytics](https://www.mavenanalytics.io/)  
**Tech Stack:** PostgreSQL, SQL  

---

### Recommendations
Based on the data-driven insights gathered, the restaurant can make the following strategic decisions:

🍔 **Menu Optimization**  
- Prioritize Top Performers: Focus on stocking and actively promoting high-demand items such as Hamburgers and Meat Lasagna, which are driving strong order volumes and revenue.  
- Revamp Underperformers: Items like Chicken Tacos showed significantly lower demand. The restaurant can consider repositioning these through promotions, recipe improvements, or replacing them entirely.

🕐 **Operational Efficiency**  
- Leverage Peak Hours: Orders spike around 12PM, 1PM, and 6PM, suggesting ideal windows for lunch and dinner promotions. Increasing staff or prepping popular dishes in advance during these times could improve service speed and customer satisfaction.  
- Prep for High Volume Orders: Some orders exceed 12 items, and the largest had over 15 items. This may indicate group or corporate orders. The restaurant could consider offering bulk order incentives or dedicated service options for large parties.

🌎 **Cuisine Development**  
- Expand High-Earning Categories: Italian, Asian, and Mexican cuisines are the top revenue generators. Introducing new dishes or limited-time specials within these categories could boost overall sales and keep the menu dynamic.  
- Balance Dish Counts: Italian and Mexican categories currently have the highest number of dishes (9 each), while American lags behind (6). Consider diversifying the American menu with trending items.

💲 **Pricing Strategy**  
- Review Pricing Anomalies: The average pricing within the Mexican category appears inconsistent. A thorough review of individual item pricing may be required to ensure alignment with perceived value and cost margins.  
- Leverage Price Points: With Italian dishes averaging the highest prices ($16.75), they present an opportunity for premium-tier menu placement or bundling strategies.
## ✅ Final Recommendations

- **Double down on best-sellers** like **Hamburgers** and **Meat Lasagna**  
- **Drop or promote** low-performing items like **Chicken Tacos**  
- Schedule **promotions** or peak-time campaigns at **12PM**, **1PM**, and **6PM**  
- **Expand** Italian, Asian, and Mexican cuisine categories  
- **Investigate pricing anomalies** in the Mexican category  
🔚 **Conclusion**  
This SQL-driven restaurant analysis provides actionable insights to improve menu design, revenue strategies, and operational planning. By understanding customer behavior and item performance, the restaurant can:  
- Increase profitability through focused promotions and better resource allocation  
- Enhance customer satisfaction by aligning offerings with preferences and trends  
- Make informed data-backed decisions that scale with business growth  

