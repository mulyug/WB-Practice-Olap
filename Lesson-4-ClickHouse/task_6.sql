
-- Task 6
-- Создать матереализованное представление для перемещения данных из stg слоя в слой текущих данных

CREATE MATERIALIZED VIEW stg.ShkOnPlace_currently TO currently.ShkOnPlace AS
select shk_id, dt, place_code, state_id
from stg.ShkOnPlace;