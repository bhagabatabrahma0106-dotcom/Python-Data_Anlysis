Banking Data Analysis Project
🏦 Project Overview
This project involves a comprehensive analysis of retail bank transaction data to understand customer behavior, channel usage, and financial risks. It utilizes a combination of Python (Pandas/NumPy) for data cleaning and initial exploration, and SQL (MS SQL Server) for advanced querying, KPI generation, and risk detection.

The analysis focuses on identifying patterns in transaction types (Deposit, Withdrawal, Transfer, Payment), monitoring channel performance (ATM, UPI, NetBanking, Branch), and flagging potential fraudulent or risky activities.

📊 Key Objectives

Data Cleaning: Standardizing date formats, handling null values, and creating new features like transaction_flag (Debit/Credit).
Transaction Analysis: Calculating total volumes and amounts by city, account type, and transaction category.
Customer Insights: Identifying top customers by transaction value and those with low or negative balances.
Channel Optimization: Analyzing the percentage contribution and average transaction amount for each banking channel.
Risk Detection: Flagging customers with multiple failed transaction attempts and identifying unusually high withdrawal patterns.


📂 Project Structure & Documents
Below are the core components of the project. You can access the documents directly through the links below:
Dataset: bank_transactions.csv: Raw transaction data containing 120 records with details such as customer IDs, amounts, and transaction status.
Python Analysis: Bank_DataAnalysis.ipynb: Jupyter Notebook containing the end-to-end data cleaning process and initial statistical summaries.
SQL Queries: Bank_Data_Analysis.sql: SQL script for database setup, ranking functions, and advanced business KPIs.



Project Documentation: MINI PROJECT_bank.docx: Detailed case study description, business context, and project requirements.

🛠️ Tools Used

Python: Pandas and NumPy for data manipulation.
SQL: MS SQL Server for complex aggregations and window functions.
Data: Excel/CSV for raw data storage.

💡 Key Business Insights

Digital Adoption: Analysis of UPI vs. ATM usage to suggest digital transition strategies.
Fraud Monitoring: Implementation of alerts for multiple failed transactions to enhance security.
Cash Flow: Tracking daily inflow vs. outflow to manage branch liquidity.
