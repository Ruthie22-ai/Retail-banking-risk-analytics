USE retail_banking_analytics;

-- MODULE 1
-- Loan Portfolio & Credit Risk Analysis

-- Task 1
-- Total Loans Issued
SELECT COUNT(*) AS total_loans_issued
FROM Loans;

-- Task 2
-- Loans Issued by Year
SELECT 
	YEAR(start_date) AS issue_year,
    COUNT(*) AS loans_issued
FROM Loans
GROUP BY YEAR(start_date)
ORDER BY issue_year;

-- Task 3
-- Loan Status Distribution
SELECT loan_status,
COUNT(*) AS loan_count
FROM loans
GROUP BY loan_status;

-- Task 4
-- Capital at Risk (Defaulted LOANS)
SELECT SUM(principal_amount) AS total_capital_at_risk
FROM loans
WHERE loan_status = "Defaulted";

-- Task 5
-- Default Rate by Customer Risk Rating
SELECT
	cu.risk_rating,
    COUNT(l.loan_id) AS total_loans,
    SUM(
		CASE
			WHEN l.loan_status = "Defaulted" THEN 1
            ELSE 0
		END
	) AS defaulted_loans,
    ROUND(
		SUM(
			CASE
				WHEN l.loan_status = "Defaulted" THEN 1
                ELSE 0
			END
		) / COUNT(l.loan_id) * 100,
        2
	) AS default_rate_pct
FROM loans l
JOIN customers cu
	ON l.customer_id = cu.customer_id
GROUP BY cu.risk_rating
ORDER BY default_rate_pct DESC;

