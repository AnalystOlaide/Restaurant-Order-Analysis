

# 🍽 Restaurant Orders Analysis (SQL Project)

## 📌 Project Title  
**Restaurant Orders Analysis**

## 📄 Project Overview  
This project explores three months of restaurant order data to uncover insights about customer preferences, item performance, and revenue trends. The restaurant offers international cuisine and operates with a digital ordering system.

The analysis is designed to help the business:
- Optimize **menu offerings**  
- Understand **peak order times**  
- Identify **revenue drivers**

## ❓ Problem Statement  
Restaurant managers often struggle with questions like:
- Which items are most/least popular?
- What times do customers order the most?
- Which menu items drive the highest revenue?

Using SQL, this project answers these questions through structured data analysis.

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
  - `JOIN`, `GROUP BY`, `ORDER BY`, `COUNT`, `SUM`, `AVG`, `LIMIT`, `EXTRACT`, Subqueries, etc.

---

## 📊 Key Insights & SQL Queries  

### 🔍 1. What was the most ordered item and category?
![WhatsApp Image 2025-04-06 at 13 30 08_00d10ac9](https://github.com/user-attachments/assets/0ffbb0de-3a2a-46e6-9adc-f24191c39d9b)

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
![WhatsApp Image 2025-04-06 at 13 31 41_8b7e9678](https://github.com/user-attachments/assets/54aace29-8f71-4d2c-b934-22ec03dba37b)

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
![WhatsApp Image 2025-04-06 at 13 32 26_3c0b2108](https://github.com/user-attachments/assets/0548e298-6051-49b8-aee8-d34aa0619d97)


```sql
SELECT COUNT(DISTINCT item_name) FROM menu_items m
JOIN order_details o ON m.menu_item_id = o.item_id;
```
**Result:** 32 items

---

### 🔍 4. Highest spend orders
![WhatsApp Image 2025-04-06 at 13 33 17_25994ab7](https://github.com/user-attachments/assets/9b397e22-1031-4b73-88c0-868e0f2e8b0f)

```sql
SELECT order_id, item_name, SUM(price) AS spend_order
FROM menu_items m JOIN order_details o
ON m.menu_item_id = o.item_id
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
![WhatsApp Image 2025-04-06 at 13 36 00_7fc84b53](https://github.com/user-attachments/assets/bba58755-c4d2-4c41-a730-fca55f9d3fc3)

```sql
SELECT EXTRACT(HOUR FROM order_time) AS order_hour, COUNT(DISTINCT order_id) AS total_orders
FROM order_details
GROUP BY order_hour
ORDER BY total_orders DESC;
```
**Result:** Peak hours = 12:00, 18:00, 13:00

---

### 🔍 6. Best-selling cuisines (by revenue) 
![WhatsApp Image 2025-04-06 at 14 14 11_57dd3639](https://github.com/user-attachments/assets/df89338b-bab0-49a4-8b83-98f937ef1da0)

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
![WhatsApp Image 2025-04-06 at 14 14 11_ee0e8874](https://github.com/user-attachments/assets/4a766fdf-ea29-468c-b35b-fadd00cceffa)

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
![WhatsApp Image 2025-04-06 at 14 15 21_18cacdf4](https://github.com/user-attachments/assets/991d7c61-80ef-4f7f-b351-deeb26b8ccec)

```sql
SELECT COUNT(*) FROM menu_items WHERE category = 'Italian';
```
**Result:** 9 dishes

---

### 🔍 9. Most expensive Italian dish 
![WhatsApp Image 2025-04-06 at 14 17 02_51e1c38d](https://github.com/user-attachments/assets/3ebb76eb-3599-417b-8ac3-f57f3813f020)

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
![WhatsApp Image 2025-04-06 at 14 18 42_c60b8067](https://github.com/user-attachments/assets/c7dab7bf-d007-4764-ad6a-e3a32934f85c)

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
![WhatsApp Image 2025-04-06 at 14 19 39_46e3c87a](https://github.com/user-attachments/assets/c0000265-acb1-4f37-a30c-145f8629dde3)

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

### 🔍 12. Order date range![WhatsApp Image 2025-04-06 at 14 22 36_e3702485](https://github.com/user-attachments/assets/e77bbb96-b4e0-4659-afd9-27327cd74061)

```sql
SELECT MIN(order_date) AS start_date, MAX(order_date) AS end_date
FROM order_details;
```
**Result:** Jan 1, 2023 – Mar 31, 2023

---

### 🔍 13. Total number of orders![WhatsApp Image 2025-04-06 at 14 23 42_1317935e](https://github.com/user-attachments/assets/38e37622-aa7c-4822-9000-52455c8a8d7f)

```sql
SELECT COUNT(DISTINCT order_id) FROM order_details;
```
**Result:** 5,370 orders

---

### 🔍 14. Total number of items ordered![WhatsApp Image 2025-04-06 at 14 24 24_c2ba3b07](https://github.com/user-attachments/assets/9fda3e8c-070a-4e5c-96b5-bcebe9cfe6e1)

```sql
SELECT COUNT(*) FROM order_details;
```
**Result:** 12,234 items

---

### 🔍 15. Order with the most items![WhatsApp Image 2025-04-06 at 14 25 10_bc922059](https://github.com/user-attachments/assets/7104ccf4-52f3-4d20-b702-bdb75081a27b)

```sql
SELECT order_id, COUNT(*) AS item_count
FROM order_details
GROUP BY order_id
ORDER BY item_count DESC
LIMIT 1;
```
**Result:** Order ID 2675

---

## ✅ Final Recommendations

- **Double down on best-sellers** like **Hamburgers** and **Meat Lasagna**
- **Drop or promote** low-performing items like **Chicken Tacos**
- Schedule **promotions** or peak-time campaigns at **12PM**, **1PM**, and **6PM**
- **Expand** Italian, Asian, and Mexican cuisine categories
- **Investigate pricing anomalies** in the Mexican category  

---



## 📌 Project Credits  
**Dataset:** [Maven Analytics](https://www.mavenanalytics.io/)  
**Tech Stack:** PostgreSQL, SQL  

---
