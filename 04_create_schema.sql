-- Description: DDL script to construct the relational database schema
--              (branches, customers, accounts, transactions) with integrity constraints.


-- Set context to Pluggable Database and Target Schema
ALTER SESSION SET CONTAINER = ORCLPDB;
ALTER SESSION SET CURRENT_SCHEMA = BANK_ADMIN;

-- 1. Create Branches table to store bank branch locations
CREATE TABLE branches (
    branch_id       NUMBER(5)           CONSTRAINT pk_branches PRIMARY KEY,
    branch_name     VARCHAR2(100)       NOT NULL,
    city            VARCHAR2(50)        NOT NULL,
    created_at      DATE DEFAULT SYSDATE NOT NULL
) TABLESPACE bank_data;

-- 2. Create Customers table with UNIQUE constraint on National ID
CREATE TABLE customers (
    customer_id     NUMBER(10)          CONSTRAINT pk_customers PRIMARY KEY,
    first_name      VARCHAR2(50)        NOT NULL,
    last_name       VARCHAR2(50)        NOT NULL,
    national_id     VARCHAR2(20)        NOT NULL CONSTRAINT uk_customer_nid UNIQUE,
    phone           VARCHAR2(15)        NOT NULL,
    email           VARCHAR2(100),
    created_at      DATE DEFAULT SYSDATE NOT NULL
) TABLESPACE bank_data;

-- 3. Create Accounts table with Foreign Keys and Business Constraints
CREATE TABLE accounts (
    account_number  NUMBER(12)          CONSTRAINT pk_accounts PRIMARY KEY,
    customer_id     NUMBER(10)          NOT NULL,
    branch_id       NUMBER(5)           NOT NULL,
    account_type    VARCHAR2(20)        NOT NULL,
    balance         NUMBER(15, 2)       DEFAULT 0.00 NOT NULL,
    status          VARCHAR2(10)        DEFAULT 'ACTIVE' NOT NULL,
    created_at      DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_acc_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_acc_branch   FOREIGN KEY (branch_id)   REFERENCES branches(branch_id),
    CONSTRAINT chk_acc_type    CHECK (account_type IN ('SAVINGS', 'CHECKING', 'CORPORATE')),
    CONSTRAINT chk_acc_status  CHECK (status IN ('ACTIVE', 'FROZEN', 'CLOSED')),
    CONSTRAINT chk_acc_balance CHECK (balance >= 0)
) TABLESPACE bank_data;

-- 4. Create Transactions table for audit logs and ledger entries
CREATE TABLE transactions (
    transaction_id   NUMBER(15)         CONSTRAINT pk_transactions PRIMARY KEY,
    account_number   NUMBER(12)         NOT NULL,
    transaction_type VARCHAR2(15)        NOT NULL,
    amount           NUMBER(12, 2)      NOT NULL,
    transaction_date DATE DEFAULT SYSDATE NOT NULL,
    description      VARCHAR2(200),

--  Relationships
    CONSTRAINT fk_txn_account FOREIGN KEY (account_number) REFERENCES accounts(account_number),

--  Business Rules    
    CONSTRAINT chk_txn_type   CHECK (transaction_type IN ('DEPOSIT', 'WITHDRAWAL', 'TRANSFER_IN', 'TRANSFER_OUT')),
    CONSTRAINT chk_txn_amount CHECK (amount > 0)
) TABLESPACE bank_data;
