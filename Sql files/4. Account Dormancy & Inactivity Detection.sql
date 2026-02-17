-- MODULE 4
-- Account Dormancy & Inactivity Detection

-- Find the Anchor Date 
SELECT 
    MAX(transaction_date) AS max_transaction_date
FROM transactions;

-- Get Last Transaction Date per Account
SELECT
    account_id,
    MAX(transaction_date) AS last_transaction_date
FROM transactions
GROUP BY account_id;


-- Identify Inactive Accounts (CORE QUERY)
SELECT
    a.account_id,
    a.customer_id,
    a.status,
    MAX(t.transaction_date) AS last_transaction_date
FROM accounts a
LEFT JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY
    a.account_id,
    a.customer_id,
    a.status
HAVING 
    last_transaction_date IS NULL
    OR last_transaction_date < DATE_SUB(
        (SELECT MAX(transaction_date) FROM transactions),
        INTERVAL 6 MONTH
    );


-- Count Inactive Accounts per Customer
SELECT
    customer_id,
    COUNT(account_id) AS inactive_account_count
FROM (
    SELECT
        a.account_id,
        a.customer_id,
        MAX(t.transaction_date) AS last_transaction_date
    FROM accounts a
    LEFT JOIN transactions t
        ON a.account_id = t.account_id
    GROUP BY
        a.account_id,
        a.customer_id
    HAVING 
        last_transaction_date IS NULL
        OR last_transaction_date < DATE_SUB(
            (SELECT MAX(transaction_date) FROM transactions),
            INTERVAL 6 MONTH
        )
) inactive_accounts
GROUP BY customer_id
ORDER BY inactive_account_count DESC;



