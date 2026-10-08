-- Description: Configures Role-Based Access Control (RBAC) by granting 
--              specific DML and EXECUTE privileges to roles and application users.

-- Set database context and enable console output
ALTER SESSION SET CONTAINER = ORCLPDB;
ALTER SESSION SET CURRENT_SCHEMA = BANK_ADMIN;
SET SERVEROUTPUT ON;

-- 1. Create Role for Bank Tellers
CREATE ROLE bank_teller;

-- Grant operational DML and Execution privileges to bank_teller role
GRANT SELECT, INSERT, UPDATE ON accounts TO bank_teller;
GRANT SELECT, INSERT ON transactions TO bank_teller;
GRANT EXECUTE ON process_transaction TO bank_teller;

-- 2. Grant Read-Only Analytical Privileges to bank_analyst role
GRANT SELECT ON vw_customer_account_summary TO bank_analyst;
GRANT SELECT ON vw_daily_transaction_summary TO bank_analyst;
GRANT SELECT ON vw_top_accounts TO bank_analyst;

-- 3. Create Teller Application User and assign Session & Role privileges
CREATE USER teller_user IDENTIFIED BY "TellerPass123#";
GRANT CREATE SESSION TO teller_user;
GRANT bank_teller TO teller_user;

PROMPT Security and Roles Configured Successfully!
