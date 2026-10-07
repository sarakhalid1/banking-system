## Oracle Banking Management System & Enterprise DB Administration

A comprehensive, production-grade Oracle Database project implementing a core banking infrastructure. This repository covers end-to-end database administration, schema management, security profiles, PL/SQL transactional logic, indexing, analytical reporting, and role-based access control (RBAC).


## Project Overview

This project simulates a complete backend banking database ecosystem built on Oracle 19c. It bridges the gap between Database Administration (DBA) and Database Development, covering:
- Storage management via custom Tablespaces.
- Enterprise security policies using User Profiles and Role-Based Access Control (RBAC).
- Relational schema design with strict integrity constraints.
- Performance optimization using Indexes and Sequences.
- Atomic financial transaction processing via PL/SQL Stored Procedures.
- Reporting automation using aggregated Views.

## Tech Stack & Environment

* Database Engine: Oracle Database 19c (Pluggable Database `ORCLPDB`)
* Core Technologies: SQL, PL/SQL, Database Administration (DBA), Data Dictionary Navigation
* OS / Environment: Oracle Linux running on Oracle VirtualBox
* Client Tool: SQL*Plus / Terminal CLI

## Repository Structure & Execution Order

The project consists of 8 sequential SQL modules reflecting an enterprise deployment workflow:


├── 01_create_tablespaces.sql          # Storage allocation: Creates dedicated Tablespaces & Datafiles
├── 02_create_security_profiles.sql    # Security policies: Password complexity, failed login limits, and session idle times
├── 03_create_users.sql                # User administration: Creates administrative accounts and assigns quotas/profiles
├── 04_create_schema.sql               # Schema DDL: Customer, Account, Branch, and Transaction tables with constraints
├── 05_create_indexes_and_sequences.sql # Performance & Keys: B-Tree indexes for fast queries & Sequences for auto-IDs
├── 06_data_and_plsql.sql              # Data & Logic: Mock data insertion & PL/SQL Stored Procedures for transfers/withdrawals
├── 07_views_and_reports.sql           # Analytics Layer: Pre-aggregated Views for customer summaries and daily transactions
└── 08_security_and_roles.sql          # Access Control: Custom roles (bank_teller, bank_analyst) and privilege grants

## Architecture & Key Highlights
1. Database Storage & Security Administration  
   * Tablespace Management: Isolates banking data into dedicated logical storage (BANK_DATA / BANK_INDX) for optimal IO             performance and backup management.
2. Security Profiles
   * Enforces enterprise password management policies (lock after failed attempts, password expiration, and session timeouts).
  
4. Schema Integrity & Performance Optimization
   * Relational Integrity: Implements Primary Keys, Foreign Keys (ON DELETE CASCADE), and CHECK constraints (e.g.,
   non-negative account balance).
   * Indexing Strategy: B-Tree indexes created on frequently searched foreign keys and transaction timestamps to accelerate         query response times.

5. Transactional Business Logic (PL/SQL)
   * Custom Stored Procedures to handle atomic banking transactions (Deposits & Withdrawals) with automated balance validation    and error handling.

5. Granular Access Control (RBAC)
   * bank_teller: Granted DML rights to process accounts/transactions and execute financial procedures.
   * bank_analyst: Granted read-only (SELECT) access restricted strictly to analytical reporting views.

## How To Run
1. Clone this repository:
   git clone [https://github.com/sarakhalid1/banking-system.git](https://github.com/sarakhalid1/banking-system.git)
   cd banking-system
2. Open Terminal and connect to your Oracle Pluggable Database via SQL*Plus:
   sqlplus sys as sysdba@ORCLPDB
3. Run the scripts in exact numerical order:
@01_create_tablespaces.sql
@02_create_security_profiles.sql
@03_create_users.sql
@04_create_schema.sql
@05_create_indexes_and_sequences.sql
@06_data_and_plsql.sql
@07_views_and_reports.sql
@08_security_and_roles.sql
