-- Description: Defines user security profiles (password policies 
--              & session limits) and custom database roles.

-- 1. Create a security profile to enforce password complexity and session management
CREATE PROFILE app_user_prof LIMIT
  FAILED_LOGIN_ATTEMPTS 3
  PASSWORD_LIFE_TIME 90
  PASSWORD_GRACE_TIME 7
  PASSWORD_REUSE_TIME 365
  SESSIONS_PER_USER 2
  IDLE_TIME 15;


-- 2. Create database role for developers with object creation privileges
CREATE ROLE bank_developer_role;
GRANT CREATE TABLE, CREATE VIEW, CREATE PROCEDURE, CREATE SEQUENCE, CONNECT, RESOURCE TO bank_developer_role;

-- 3. Create database role for bank tellers with connection privileges
CREATE ROLE bank_teller_role;
GRANT CONNECT TO bank_teller_role;
