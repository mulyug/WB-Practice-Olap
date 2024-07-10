
-- Task 7
-- Смоделировать вставку данных в буфферную таблицу для stg слоя.
-- В конечном итоге данные должны быть заполнены и в stg слое, и в слое текущих данных.

INSERT INTO direct_log.ShkOnPlace(shk_id, dt, place_code, state_id)
select 222222, now() - interval 12 hour, 987987, 'ASI'
union all
select 222222, now(), 985334, 'JAP';

select * from stg.ShkOnPlace;
select * from currently.ShkOnPlace final;
