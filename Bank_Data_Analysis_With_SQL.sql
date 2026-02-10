--Craete Database to stire the data
CREATE DATABASE	SBI_Bank;


--Use this database as source
USE SBI_Bank;

--Rename the Table
EXEC sp_rename 'dbo.bank_data$', 'bank_data';


/* =========================================================
   BANKING DATA ANALYSIS PROJECT – MS SQL SERVER
   Dataset  : bank_data
   Purpose  : Transaction Analysis, Risk Detection, KPIs
   ========================================================= */

------------------------------------------------------------
-- PHASE 1: DATA UNDERSTANDING & CLEANING
------------------------------------------------------------

-- View table structure
SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'bank_data';

-- Total rows
SELECT COUNT(*) AS Total_Records 
FROM bank_data;

-- Check NULL values
SELECT
    SUM(CASE WHEN transaction_date IS NULL THEN 1 ELSE 0 END) AS Null_Dates,
    SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS Null_Amounts,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS Null_Customers
FROM bank_data;

-- Duplicate transactions
SELECT transaction_id, COUNT(*) AS Duplicate_Count
FROM bank_data
GROUP BY transaction_id
HAVING COUNT(*) > 1;

-- Add Debit / Credit Flag
ALTER TABLE bank_data
ADD transaction_flag VARCHAR(10);

UPDATE bank_data
SET transaction_flag = 
CASE 
    WHEN transaction_type IN ('Withdrawal','Payment','Transfer') THEN 'Debit'
    ELSE 'Credit'
END;

------------------------------------------------------------
-- PHASE 2: TRANSACTION ANALYSIS
------------------------------------------------------------

-- Total number of transactions
SELECT COUNT(*) AS Total_Transactions
FROM bank_data;

-- Total amount by transaction type
SELECT transaction_type, SUM(amount) AS Total_Amount
FROM bank_data
GROUP BY transaction_type;

-- Account type wise amount
SELECT account_type, SUM(amount) AS Total_Amount
FROM bank_data
GROUP BY account_type;

-- City wise transaction volume
SELECT city, SUM(amount) AS City_Volume
FROM bank_data
GROUP BY city
ORDER BY City_Volume DESC;

-- Monthly transaction trend
SELECT 
    FORMAT(transaction_date, 'yyyy-MM') AS Month,
    SUM(amount) AS Monthly_Amount
FROM bank_data
GROUP BY FORMAT(transaction_date, 'yyyy-MM')
ORDER BY Month;

-- Failed transaction percentage
SELECT 
    ROUND(COUNT(CASE WHEN status = 'Failed' THEN 1 END) * 100.0 / COUNT(*),2) AS Failed_Percentage
FROM bank_data;

------------------------------------------------------------
-- PHASE 3: CUSTOMER & CHANNEL INSIGHTS
------------------------------------------------------------

-- Top 5 customers by transaction value
SELECT TOP 5 
    customer_id, 
    customer_name, 
    SUM(amount) AS Total_Transaction_Value
FROM bank_data
GROUP BY customer_id, customer_name
ORDER BY Total_Transaction_Value DESC;

-- Customers with low or negative balance
SELECT *
FROM bank_data
WHERE balance < 1000;

-- Channel-wise contribution percentage
SELECT 
    channel,
    SUM(amount) * 100.0 / (SELECT SUM(amount) FROM bank_data) AS Channel_Contribution_Percent
FROM bank_data
GROUP BY channel;

-- Average transaction amount per channel
SELECT channel, AVG(amount) AS Avg_Transaction_Amount
FROM bank_data
GROUP BY channel;

-- Customers with unusually high withdrawals
SELECT TOP 5 
    customer_id, 
    SUM(amount) AS Total_Withdrawal
FROM bank_data
WHERE transaction_type = 'Withdrawal'
GROUP BY customer_id
ORDER BY Total_Withdrawal DESC;

------------------------------------------------------------
-- PHASE 4: RANKING & WINDOW FUNCTIONS
------------------------------------------------------------

-- Rank customers by total transaction amount
SELECT 
    customer_id,
    SUM(amount) AS Total_Amount,
    RANK() OVER (ORDER BY SUM(amount) DESC) AS Customer_Rank
FROM bank_data
GROUP BY customer_id;

------------------------------------------------------------
-- PHASE 5: RISK & FRAUD INDICATORS
------------------------------------------------------------

-- Customers with multiple failed attempts
SELECT 
    customer_id,
    COUNT(*) AS Failed_Count
FROM bank_data
WHERE status = 'Failed'
GROUP BY customer_id
HAVING COUNT(*) >= 3;

-- Sudden high withdrawal compared to average

-- ATM cash dependency
SELECT 
    customer_id,
    SUM(CASE WHEN channel = 'ATM' THEN amount ELSE 0 END) AS ATM_Usage
FROM bank_data
GROUP BY customer_id
ORDER BY ATM_Usage DESC;

-- Balance volatility (risk indicator)


select * from bank_data;

