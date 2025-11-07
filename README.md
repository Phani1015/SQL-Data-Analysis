# 🛍️ Ajio Sales Data Analysis using SQL

## 📘 Project Overview
This project focuses on analyzing **Ajio’s e-commerce sales data** using **SQL** to uncover insights about revenue trends, customer behavior, discount effectiveness, product performance, and delivery efficiency.

The analysis is performed on **7 relational tables** that capture various aspects of Ajio’s business operations — products, customers, orders, coupons, returns, ratings, and delivery details.

---

## 🎯 Problem Statement
Ajio aims to **increase revenue and customer satisfaction** by analyzing:
- Product sales and profitability trends  
- Delivery performance and customer feedback  
- The impact of discounts and coupons  
- Customer loyalty and purchasing behavior  

Through SQL queries, this project identifies key performance indicators (KPIs) to support **data-driven business decisions**.

---

## 🧩 Database Structure
The database consists of **7 tables**:
1. **Products** – Product ID, name, price, category, company, etc.  
2. **Orders** – Order details including quantity, date, customer ID, and product ID.  
3. **Customer** – Customer demographic and location information.  
4. **Ratings** – Product, delivery, and service rating details.  
5. **Returns** – Returned orders and reasons for returns.  
6. **Delivery** – Delivery personnel information and ratings.  
7. **Coupons/Discounts** – Discount and coupon data used in orders.  

---

## 🧮 Tools Used
- **MySQL / SQL Workbench** – Data querying and analysis  
- **Excel** – Data review and tabulation  
- **ER Diagram** – Schema design and relationship mapping  

---

## 📊 Key Analysis Areas & Questions Answered

### 🔹 Sales & Revenue Analysis
1. Top 10 products generating the highest revenue  
2. Product categories contributing the most to sales  
3. Monthly sales trends over the last year  
4. Most preferred companies by customers  
5. Average order value (AOV) across all customers  

### 🔹 Customer Behavior Analysis
6. Customers with the highest number of orders  
7. Total spending per customer and order frequency  
8. Gender influence on product purchases  
9. Top cities/states by sales volume  
10. Loyal customers with repeated purchases  

### 🔹 Discounts & Promotions
11. Impact of discounts and coupons on total revenue  
12. Percentage of orders using coupons vs. without  
13. Coupon codes leading to the highest sales  

### 🔹 Returns & Ratings
14. Products with the highest return rates and reasons  
15. Average product rating by category and company  

### 🔹 Delivery & Service Performance
16. Delivery personnel with the highest average ratings  
17. Average delivery time and its effect on customer ratings  
18. Correlation between delivery rating and repeat orders  

### 🔹 Profitability & Efficiency
19. Products generating the highest profit margins  
20. Customers/locations with highest revenue and lowest returns  

---

## 🧠 Insights Summary
- **Blazers and Skirts** were the top revenue-generating categories.  
- Around **49% of all orders used coupons**, showing a balanced mix of promotional and organic sales.  
- **Visakhapatnam, Chennai, and Nagpur** were top-performing cities in terms of revenue.  
- **Defective items and wrong shipments** were the most common return reasons.  
- **Faster deliveries** and **higher delivery ratings** were correlated with **higher repeat orders**.  
- **Top-performing products and customers** can help Ajio optimize stock and marketing strategies.  

---

## 🚀 Future Improvements
- Add a `delivery_time` column to calculate real delivery performance metrics.  
- Create **visual dashboards** using **Power BI** or **Tableau**.  
- Automate query execution and reporting using **Python (Pandas + SQLAlchemy)**.  
- Expand the analysis to include time-series forecasting for sales trends.  

---

## 📂 Repository Structure
