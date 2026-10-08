-- Description: Creates database sequences for auto-generating primary keys 
--              and B-Tree indexes on foreign keys to optimize query performance.

-- Set context to Pluggable Database and Target Schema
ALTER SESSION SET CONTAINER = ORCLPDB;
ALTER SESSION SET CURRENT_SCHEMA = BANK_ADMIN;

-- 1. Sequences for generating auto-incrementing Primary Keys
CREATE SEQUENCE seq_customer_id
    START WITH 1001
    INCREMENT BY 1
    NOCACHE;

CREATE SEQUENCE seq_transaction_id
    START WITH  500001
    INCREMENT BY 1
    NOCACHE;


-- 2. B-Tree Indexes on frequently searched columns and foreign keys for query optimization
CREATE INDEX idx_cust_phone ON customers(phone) TABLESPACE bank_indx;

CREATE INDEX idx_acc_customer_id ON accounts(customer_id) TABLESPACE bank_indx;
CREATE INDEX idx_acc_branch_id ON accounts(branch_id) TABLESPACE bank_indx;

CREATE INDEX idx_txn_account_num ON transactions(account_number) TABLESPACE bank_indx;
CREATE INDEX idx_txn_date ON transactions(transaction_date) TABLESPACE bank_indx;
