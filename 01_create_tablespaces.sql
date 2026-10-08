-- Description: Creates dedicated logical storage spaces (Tablespaces)
--              for core application data and performance indexes.


-- 1. Create Data Tablespace for storing main application tables
CREATE TABLESPACE bank_data
  DATAFILE '/u01/app/oracle/oradata/ORCL/5D081DDF6AB3DF26E0650A0027F6BABE/datafile/bank_data01.dbf'
  SIZE 100M
  AUTOEXTEND ON NEXT 10M MAXSIZE 1G
  EXTENT MANAGEMENT LOCAL
  SEGMENT SPACE MANAGEMENT AUTO;


-- 2. Create Index Tablespace dedicated to B-Tree indexes for fast query performance
CREATE TABLESPACE bank_indx
  DATAFILE '/u01/app/oracle/oradata/ORCL/5D081DDF6AB3DF26E0650A0027F6BABE/datafile/bank_indx01.dbf'
  SIZE 50M
  AUTOEXTEND ON NEXT 5M MAXSIZE 500M
  EXTENT MANAGEMENT LOCAL
  SEGMENT SPACE MANAGEMENT AUTO;
