-- MODULE 5
-- High-Value, Low-Engagement Customer Segmentation 

-- Define “High Value” 
-- Option A: Above-Average Balance
SELECT 
    AVG(balance) AS avg_account_balance
FROM accounts;
-- High value = total customer balance above average

-- Define “Low Engagement”
-- Low engagement = few transactions in the last 6 months

-- Customer Balance (Aggregation)
SELECT
    customer_id,
    SUM(balance) AS total_customer_balance
FROM accounts
GROUP BY customer_id;

-- Customer Transaction Count (Last 6 Months)
SELECT
    a.customer_id,
    COUNT(t.transaction_id) AS txn_count_last_6_months
FROM accounts a
LEFT JOIN transactions t
    ON a.account_id = t.account_id
   AND t.transaction_date >= DATE_SUB(
       (SELECT MAX(transaction_date) FROM transactions),
       INTERVAL 6 MONTH
   )
GROUP BY a.customer_id;

-- FINAL SEGMENTATION QUERY (CORE DELIVERABLE)
SELECT
    b.customer_id,
    b.total_customer_balance,
    IFNULL(t.txn_count_last_6_months, 0) AS txn_count_last_6_months
FROM (
    SELECT
        customer_id,
        SUM(balance) AS total_customer_balance
    FROM accounts
    GROUP BY customer_id
) b
LEFT JOIN (
    SELECT
        a.customer_id,
        COUNT(t.transaction_id) AS txn_count_last_6_months
    FROM accounts a
    LEFT JOIN transactions t
        ON a.account_id = t.account_id
       AND t.transaction_date >= DATE_SUB(
           (SELECT MAX(transaction_date) FROM transactions),
           INTERVAL 6 MONTH
       )
    GROUP BY a.customer_id
) t
    ON b.customer_id = t.customer_id
WHERE b.total_customer_balance > (
    SELECT AVG(balance) FROM accounts
)
AND IFNULL(t.txn_count_last_6_months, 0) < 5
ORDER BY b.total_customer_balance DESC;
