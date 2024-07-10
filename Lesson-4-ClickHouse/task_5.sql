
-- Task 5
-- Реализовать через буфферную таблицу заполнение stg слоя

INSERT INTO direct_log.ShkOnPlace(shk_id, dt, place_code, state_id)
select 111111, now() - interval 1 day, 987654, 'ASI'
union all
select 111111, now(), 981234, 'BAP';

select * from direct_log.ShkOnPlace;
select * from stg.ShkOnPlace;