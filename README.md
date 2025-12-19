# Cyber Security SQL Analysis Project

## Project Overview

This project focuses on analyzing **cyber security incidents** using SQL. 
The dataset contains detailed information about cyber attacks across different countries and years, 
including attack types, financial losses, affected users, vulnerabilities, and resolution times.

The main goal of this project is to **practice SQL queries** and **extract meaningful insights**
that can help understand cyber attack patterns, risks, and impacts.

---

## Dataset Description

The dataset consists of approximately **3,000 records** with the following key columns:

| Column Name     | Description                                          |
| --------------- | ---------------------------------------------------- |
| country         | Country where the cyber attack occurred              |
| year            | Year of the attack                                   |
| attack_type     | Type of cyber attack (e.g., Malware, Phishing, DDoS) |
| financial_loss  | Financial loss caused by the attack                  |
| affected_users  | Number of users affected                             |
| vulnerability   | Security vulnerability exploited                     |
| resolution_time | Time taken to resolve the incident                   |

---

## Objectives

* Analyze cyber attacks across countries and years
* Identify the most common attack types
* Calculate total and average financial losses
* Find countries most affected by cyber attacks
* Analyze resolution time patterns
* Understand vulnerabilities frequently exploited

---

## SQL Concepts Used

This project covers the following SQL concepts:

* SELECT, WHERE, ORDER BY
* GROUP BY & HAVING
* Aggregate Functions (SUM, AVG, COUNT, MAX, MIN)
* CASE Statements
* Subqueries
* Joins (if extended)
* Views (optional)

---

##  Sample SQL Queries

### 1️⃣ Total Cyber Attacks by Country

```sql
SELECT country, COUNT(*) AS total_attacks
FROM cyber_security
GROUP BY country
ORDER BY total_attacks DESC;
```

### 2️⃣ Total Financial Loss by Attack Type

```sql
SELECT attack_type, SUM(financial_loss) AS total_loss
FROM cyber_security
GROUP BY attack_type
ORDER BY total_loss DESC;
```

### 3️⃣ Average Resolution Time by Year

```sql
SELECT year, AVG(resolution_time) AS avg_resolution_time
FROM cyber_security
GROUP BY year
ORDER BY year;
```

---

## Key Insights (Example)

* Certain countries experience a significantly higher number of cyber attacks
* Malware and Phishing are among the most frequent attack types
* Financial losses have increased over recent years
* Some vulnerabilities are repeatedly exploited

*(Insights may vary based on queries and analysis)*

---

## Tools & Technologies

* **Database:** MySQL / SQL
* **IDE:** MySQL Workbench / VS Code
* **Language:** SQL

---

## How to Use This Project

1. Clone this repository
2. Import the dataset into your SQL database
3. Run the queries from the `.sql` file
4. Modify or create new queries to explore further insights

---
