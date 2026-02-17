USE retail_banking_analytics;

-- MODULE 2
-- Customer Financial Health Assessment

-- To confirm the relationship chain
SELECT 
COUNT(*) AS total_accounts,
COUNT(customer_id) AS totaL_customers
FROM accounts;

-- Task 1
-- Customers who fully repaid loans but have low balances

-- Total balance per customer
SELECT customer_id,
SUM(balance) AS total_customer_balance
FROM accounts
GROUP BY customer_id;

-- Total principal repaid per customer (Closed loans only)
SELECT customer_id,
SUM(principal_amount) AS total_principal_repaid
FROM loans
WHERE loan_status = "Closed"
GROUP BY customer_id;

-- Combine and flag customers
SELECT 
	l.customer_id,
    SUM(l.principal_amount) AS total_principal_repaid,
    SUM(a.balance) AS total_customer_balance
FROM loans l
JOIN accounts a
	ON l.customer_id = a.customer_id
WHERE l.loan_status = "Closed"
GROUP BY l.customer_id
HAVING SUM(a.balance) < SUM(l.principal_amount);

-- Task 2
-- Customers who defaulted on loans but still maintain high account balances

-- Define High balance
SELECT AVG(balance) AS avg_balance
FROM accounts;
-- let's say High Balance = Above Average

-- Identify Customers
SELECT
	l.customer_id,
    SUM(l.principal_amount) AS total_defaulted_amount,
    SUM(a.balance) AS total_customer_balance
FROM loans l
JOIN accounts a
	ON l.customer_id = a.customer_id
WHERE l.loan_status = "Defaulted"
GROUP BY l.customer_id
HAVING SUM(a.balance) > (
	SELECT AVG(balance) FROM accounts
);

