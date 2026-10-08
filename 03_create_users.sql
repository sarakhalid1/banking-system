Description: Creates application database users, assigns default
--           tablespaces, storage quotas, profiles, and roles.

-- 1. Create Administrator user with full storage quotas and developer role
CREATE USER bank_admin IDENTIFIED BY "Secure_Pass123#"
  DEFAULT TABLESPACE bank_data
  TEMPORARY TABLESPACE temp
  QUOTA UNLIMITED ON bank_data
  QUOTA UNLIMITED ON bank_indx
  PROFILE app_user_prof;

GRANT bank_developer_role TO bank_admin;

-- 2. Create Teller user with restricted storage quota and teller role
CREATE USER teller_user IDENTIFIED BY "Teller_Pass123#"
  DEFAULT TABLESPACE bank_data
  TEMPORARY TABLESPACE temp
  QUOTA 10M ON bank_data
  PROFILE app_user_prof;

GRANT bank_teller_role TO teller_user;
