
-- Task 3
-- Создать базы для стейджинга, исторических данных, текущих данных и буферных таблиц

CREATE DATABASE stg;
CREATE DATABASE currently;
CREATE DATABASE history;
CREATE DATABASE direct_log;

--------------------

CREATE TABLE IF NOT EXISTS stg.ShkOnPlace
(
    shk_id      Int64,
    dt          DateTime,
    place_code  UInt64,
    state_id    LowCardinality(String)
)
ENGINE = MergeTree()
ORDER BY shk_id;


CREATE TABLE IF NOT EXISTS history.ShkOnPlace
(
    shk_id      Int64,
    dt          DateTime,
    place_code  UInt64,
    state_id    LowCardinality(String)
)
ENGINE = MergeTree()
ORDER BY shk_id;


CREATE TABLE IF NOT EXISTS currently.ShkOnPlace
(
    shk_id      Int64,
    dt          DateTime,
    place_code  UInt64,
    state_id    LowCardinality(String)
)
ENGINE = ReplacingMergeTree()
ORDER BY shk_id;


CREATE TABLE IF NOT EXISTS direct_log.ShkOnPlace
(
    shk_id      Int64,
    dt          DateTime,
    place_code  UInt64,
    state_id    LowCardinality(String)
)
ENGINE = Buffer('stg', 'ShkOnPlace', 16, 10, 100, 10000, 1000000, 10000000, 100000000);