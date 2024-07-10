
-- Task 2
-- Настроить пользователя администратора

CREATE USER mulyukov_admin IDENTIFIED WITH sha256_password BY '123456';
GRANT CURRENT GRANTS ON *.* TO mulyukov_admin WITH GRANT OPTION;