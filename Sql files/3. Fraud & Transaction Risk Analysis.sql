USE retail_banking_analytics;

-- MODULE 3
-- Fraud & Transaction Risk Analysis

-- Task 1
-- Identify unusually large withdrawals relative to historical customer behavior

-- Computing average transaction size per account
SELECT
	account_id,
    AVG(ABS(amount)) AS avg_txn_amount -- withdrawal may be negative
FROM transactions
 GROUP BY account_id;

-- Flag unusually large withdrawals
-- i.e. A transaction > 3 x account's average transaction size
SELECT
	t.transaction_id,
    t.account_id,
    t.transaction_date,
    t.amount,
    a.avg_txn_amount
FROM transactions t
JOIN (
	SELECT 
		account_id,
        AVG(ABS(amount)) AS avg_txn_amount
	FROM transactions
    GROUP BY account_id
) a
	ON t.account_id = a.account_id
WHERE t.amount < 0
	AND ABS(t.amount) > 3 * a.avg_txn_amount;
    
-- Task 2
-- Fraud distribution by transaction channel


SELECT
    t.channel,
    COUNT(f.transaction_id) AS confirmed_fraud_count
FROM transactions t
LEFT JOIN fraud_flags f
    ON t.transaction_id = f.transaction_id
   AND f.status = 'Confirmed'
GROUP BY t.channel
ORDER BY confirmed_fraud_count DESC;

-- Task 3
-- Fraud rate by channel (CORRECT denominator logic)

SELECT
    t.channel,
    COUNT(*) AS total_transactions,
    SUM(
        CASE 
            WHEN f.status = 'Confirmed' THEN 1 
            ELSE 0 
        END
    ) AS fraud_transactions,
    ROUND(
        SUM(
            CASE 
                WHEN f.status = 'Confirmed' THEN 1 
                ELSE 0 
            END
        ) / COUNT(*) * 100,
        2
    ) AS fraud_rate_pct
FROM transactions t
LEFT JOIN fraud_flags f
    ON t.transaction_id = f.transaction_id
GROUP BY t.channel
ORDER BY fraud_rate_pct DESC;


-- Task 4 
-- Accounts with repeated confirmed fraud

SELECT
    t.account_id,
    COUNT(*) AS fraud_count
FROM transactions t
JOIN fraud_flags f
    ON t.transaction_id = f.transaction_id
WHERE f.status = 'Confirmed'
GROUP BY t.account_id
HAVING COUNT(*) > 1
ORDER BY fraud_count DESC;


