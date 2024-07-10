
-- Task 4
-- Создать роль только для чтения и роль с возможность создавать и заполнять данные в БД стейджинга (stg).
-- Создать двух пользователей с такими правами по умолчанию.

CREATE ROLE readonly;
GRANT SELECT ON *.* TO readonly;

CREATE ROLE write_to_stg;
GRANT CREATE, INSERT ON stg.* TO write_to_stg;

--------------------

CREATE USER IF NOT EXISTS mulyukov_readonly DEFAULT ROLE readonly;

CREATE USER IF NOT EXISTS mulyukov_writer DEFAULT ROLE write_to_stg;