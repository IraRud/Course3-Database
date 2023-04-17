-- [Работа с несколькими таблицами]

-- создайте таблицу city с колонками city_id и city_name
CREATE TABLE city
(
    -- первичный ключ
    city_id   BIGSERIAL   NOT NULL PRIMARY KEY,
    city_name VARCHAR(20) NOT NULL
);

-- добавьте в таблицу employee колонку city_id. Назначьте эту колонку внешним ключом
-- свяжите таблицу employee с таблицей city (One to Many)
-- редактирование таблицы ALTER TABLE
ALTER TABLE employee
    -- добавление столбца ADD
    ADD city_id INT,
    -- назначение его внешним ключом
    ADD FOREIGN KEY (city_id) REFERENCES city (city_id);

SELECT *
FROM employee;

-- заполните таблицу city
INSERT INTO city (city_name)
VALUES ('Москва'),
       ('Вашингтон'),
       ('Сеул'),
       ('Лондон');

-- назначьте работникам соответствующие города
UPDATE employee SET city_id = (SELECT city_id FROM city WHERE city_name ='Лондон') WHERE id = 1;
UPDATE employee SET city_id = (SELECT city_id FROM city WHERE city_name ='Вашингтон') WHERE id = 3;
UPDATE employee SET city_id = (SELECT city_id FROM city WHERE city_name ='Лондон') WHERE id = 4;
UPDATE employee SET city_id = (SELECT city_id FROM city WHERE city_name ='Москва') WHERE id = 5;
UPDATE employee SET city_id = (SELECT city_id FROM city WHERE city_name ='Сеул') WHERE id = 6;

SELECT *
FROM employee;

-- после заполнения для уже существующих полей атрибута city_name можно наложить ограничение NOT NULL
ALTER TABLE employee
    ALTER COLUMN city_id SET NOT NULL;
