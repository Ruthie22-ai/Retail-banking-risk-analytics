/* create the database and name it "retail_banking_analytics" */
CREATE DATABASE retail_banking_analytics;

/* Use the database that was created  */
USE retail_banking_analytics;

/* Create the tables  */
CREATE TABLE Accounts (
	account_id	int	primary key,
	customer_id	int,
	account_type	varchar(10),	
	balance	decimal (12,2),
	currency	char(3),
	status	varchar(10),
	opened_date	date	
);

CREATE TABLE Loans (
	loan_id	int	primary key	,
	customer_id	int		,
	loan_type	varchar(15)		,
	principal_amount	decimal (12,2)		,
	interest_rate	decimal (12,2)		,
	loan_status	varchar(15)		,
	start_date	date		,
	end_date	date		
);

CREATE TABLE Customers (
	customer_id	int	primary key	,
	first_name	varchar(20)	,	
	last_name	varchar(20)	,	
	gender	varchar(10)	,	
	date_of_birth	date	,	
	city	varchar(10)	,	
	state	varchar(10)	,	
	customer_since	date	,	
	risk_rating	varchar(10)		
);

CREATE TABLE Fraud_flags (
	flag_id	int	primary key	,
	transaction_id	int	,	
	fraud_type	varchar(25)	,	
	flagged_date	date	,	
	status	varchar(25)		
);

CREATE TABLE Cards (
	card_id	int	primary key	,
	account_id	int	,	
	card_type	varchar(10)	,	
	card_status	varchar(10)	,	
	issued_date	date		
);

CREATE TABLE Transactions (
	transaction_id	int	primary key	,
	account_id	int	,	
	transaction_date	date	,	
	transaction_type	varchar(15)	,	
	amount	decimal 12,2	,	
	channel	varchar(15)		
);