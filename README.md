# 🏦 Retail Banking Risk, Fraud & Customer Analytics (SQL Project)

## 📌 Project Overview

This project is an end-to-end **SQL analytics case study** simulating real-world analysis within a retail banking environment.

The objective is to assess:

- Credit risk exposure  
- Loan portfolio performance  
- Fraud incidence and patterns  
- Customer financial health  
- Account dormancy  
- High-value customer engagement  

The project demonstrates how SQL can be used as a **decision-support tool**, not just a querying language.

---

## 🎯 Business Context

Retail banks generate large volumes of customer and transactional data. However, operational data alone does not answer key strategic questions such as:

- Where is credit risk concentrated?
- Do internal risk ratings predict defaults?
- What proportion of transactions are confirmed fraud?
- Which accounts are inactive?
- Which high-value customers are disengaging?

This project answers those questions using structured SQL analysis.

---

## 🗂️ Dataset Description

The analysis is based on the following relational tables:

| Table | Description |
|--------|-------------|
| `customers` | Customer demographic and risk rating data |
| `accounts` | Account information including balances and status |
| `loans` | Loan portfolio data including amount and status |
| `transactions` | Transaction-level activity data |
| `fraud_flags` | Fraud investigation outcomes |
| `cards` | Card issuance data linked to accounts |

All datasets were imported into **MySQL** from CSV files.

---

## 🧱 Data Model & Relationships

The relational structure used:

- `customers.customer_id` → `accounts.customer_id`
- `customers.customer_id` → `loans.customer_id`
- `accounts.account_id` → `transactions.account_id`
- `transactions.transaction_id` → `fraud_flags.transaction_id`
- `accounts.account_id` → `cards.account_id`

Special attention was given to:

- Correct JOIN selection (INNER vs LEFT)
- Avoiding duplicate aggregations
- Preserving proper data grain
- Accurate filtering logic placement

---

## 📊 Analytical Modules

### 1️⃣ Loan Portfolio & Credit Risk Analysis

- Loan distribution by status  
- Overall default rate  
- Default rate by internal risk rating  
- Total capital at risk  

**Key Insight:** Higher risk ratings generally align with higher default rates.

---

### 2️⃣ Customer Financial Health Assessment

- Average balance by loan outcome  
- Customers defaulting despite strong balances  

**Key Insight:** Some customers default while holding significant liquidity.

---

### 3️⃣ Fraud & Transaction Risk Analysis

- Fraud status distribution  
- Confirmed fraud by type  
- Fraud rate relative to transaction volume  

**Key Insight:** Fraud cases are relatively rare but concentrated.

---

### 4️⃣ Account Dormancy Detection

- Last transaction date per account  
- Accounts inactive for six months or more  

**Key Insight:** Dormant accounts signal engagement and churn risk.

---

### 5️⃣ High-Value, Low-Engagement Customer Segmentation

- Customers with high balances but low recent activity  

**Key Insight:** These customers represent strong retention opportunities.

---

## 🛠️ Technical Approach

- **Database:** MySQL  
- **Data Source:** CSV  
- **Core SQL Techniques Used:**
  - `SUM`, `COUNT`, `AVG`
  - `CASE WHEN`
  - `GROUP BY` and `HAVING`
  - `DATE_SUB` for rolling window logic
  - Subqueries for time anchoring

Example snippet:

```sql
SELECT 
    COUNT(CASE WHEN loan_status = 'Defaulted' THEN 1 END) * 100.0 / COUNT(*) AS default_rate_pct
FROM loans;
