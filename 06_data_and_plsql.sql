-- Description: Inserts initial sample seed data and creates core PL/SQL 
--              stored procedure for transactional operations with safety checks.

-- Set database context and enable console output
ALTER SESSION SET CONTAINER = ORCLPDB;
ALTER SESSION SET CURRENT_SCHEMA = BANK_ADMIN;
SET SERVEROUTPUT ON;

-- 1. Seed Initial Data (Branches, Customers, Accounts)

-- Insert sample branches
INSERT INTO branches(branch_id, branch_name, city)
VALUES (101, 'Khartoum Main Branch', 'Khartoum');

INSERT INTO branches(branch_id, branch_name, city)
VALUES (102, 'Omdurman Branch', 'Omdurman');

-- Insert sample customers using customer ID sequence
INSERT INTO customers (customer_id, first_name, last_name, national_id, phone, email)
Values (seq_customer_id.NEXTVAL, 'Sara', 'Khalid', 'SD-10928374', '0912345678', 'sara@example.com');

INSERT INTO customers (customer_id, first_name, last_name, national_id, phone, email) 
VALUES (seq_customer_id.NEXTVAL, 'Ahmed', 'Mustafa', 'SD-56473829', '0987654321', 'ahmed@example.com');

-- Insert sample bank accounts
INSERT INTO accounts (account_number, customer_id, branch_id, account_type, balance, status)
VALUES (1011001001, 1001, 101, 'SAVINGS', 5000.00, 'ACTIVE');

INSERT INTO accounts (account_number, customer_id, branch_id, account_type, balance, status) 
VALUES (1021002001, 1002, 102, 'CHECKING', 1200.00, 'ACTIVE');

COMMIT;

-- 2. PL/SQL Stored Procedure: Process Deposits and Withdrawals


CREATE OR REPLACE PROCEDURE process_transaction (
    p_account_number IN NUMBER,
    p_txn_type IN VARCHAR2,
    p_amount IN NUMBER,
    p_description IN VARCHAR2 DEFAULT NULL
) IS
    v_current_balance NUMBER(15,2);
BEGIN
    -- Lock account record for update to prevent concurrent race conditions
    SELECT balance INTO v_current_balance
    FROM accounts
    WHERE account_number = p_account_number
    FOR UPDATE;

    -- Handle Deposit transaction logic
    IF p_txn_type = 'DEPOSIT'THEN
        UPDATE accounts
        SET balance = balance + p_amount
        WHERE account_number = p_account_number;

    -- Handle Withdrawal transaction logic with balance validation
    ELSIF p_txn_type = 'WITHDRAWAL' THEN
        IF v_current_balance < p_amount THEN
           RAISE_APPLICATION_ERROR (-20001, 'Insufficient funds for this withdrawal.');
        END IF;
        UPDATE accounts
        SET balance = balance - p_amount
        WHERE account_number = p_account_number;
    ELSE
        RAISE_APPLICATION_ERROR (-20002, 'Invalid transaction type.');
    END IF;

    -- Log transaction into ledger table
    INSERT INTO transactions (transaction_id, account_number, transaction_type, amount, description)
    VALUES (seq_transaction_id.NEXTVAL, p_account_number, p_txn_type, p_amount, p_description);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transaction completed successfully.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'Account number does not exist.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END process_transaction;
/
