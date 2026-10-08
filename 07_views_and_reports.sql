-- Description: Creates database views to aggregate analytical data, 
--              customer balance summaries, and daily transaction reports.

-- Set database context and enable console output
ALTER SESSION SET CONTAINER = ORCLPDB;
ALTER SESSION SET CURRENT_SCHEMA = BANK_ADMIN;
SET SERVEROUTPUT ON;

-- 1. View: Comprehensive Customer Account Summary
CREATE OR REPLACE VIEW vw_customer_account_summary AS 
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS full_name,
    c.phone,
    a.account_number,
    a.account_type,
    a.balance,
    a.status AS account_status,
    b.branch_name,
    b.city
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN branches b ON a.branch_id = b.branch_id;

-- 2. View: Daily Transaction Summary Aggregated by Type
CREATE OR REPLACE VIEW vw_daily_transaction_summary AS
SELECT
    TRUNC(transaction_date) AS txn_date,
    transaction_type,
    COUNT(transaction_id) AS total_transactions,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY TRUNC(transaction_date), transaction_type;

-- 3. View: Top Accounts Ranked by Highest Balance
CREATE OR REPLACE VIEW vw_top_accounts AS
SELECT
    account_number,
    account_type,
    balance
FROM accounts
ORDER BY balance DESC;
PROMPT Views Created Successfully! 
