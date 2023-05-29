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

-- после заполнения атрибута city_name для уже существующих полей на него можно наложить ограничение NOT NULL
-- ALTER TABLE employee
--     ALTER COLUMN city_id SET NOT NULL;

-- для проверки добавим город без сотрудника
INSERT INTO city (city_name)
VALUES ('Оттава');
-- и сотрудника без города
INSERT INTO employee(first_name, last_name, gender, age)
VALUES ('Гарри', 'Стайлс', 'муж.', 29);

-- получите имена и фамилии сотрудников, а также города, в которых они проживают
SELECT employee.first_name AS Имя, employee.last_name AS Фамилия, city.city_name AS Город
FROM city
         RIGHT JOIN employee ON city.city_id = employee.city_id;

-- получите города, а также имена и фамилии сотрудников, которые в них проживают
-- если в городе никто из сотрудников не живет, то вместо имени должен стоять null
SELECT city.city_name AS Город, employee.first_name AS Имя, employee.last_name AS Фамилия
FROM city
         LEFT JOIN employee ON city.city_id = employee.city_id;

-- получите имена всех сотрудников и названия всех городов
-- если в городе не живет никто из сотрудников, то вместо имени должен стоять null
-- аналогично, если города для какого-то из сотрудников нет в списке, должен быть получен null
SELECT employee.first_name AS Имя, employee.last_name AS Фамилия, city.city_name AS Город
FROM employee
         FULL OUTER JOIN city ON employee.city_id = city.city_id;

-- получите таблицу, в которой каждому имени должен соответствовать каждый город
SELECT employee.first_name AS Имя, employee.last_name AS Фамилия, city.city_name AS Город
FROM employee
         CROSS JOIN city;

-- получите имена городов, в которых никто не живет
SELECT city.city_name AS Город
-- выбор всех городов
FROM city
    -- и какие сотрудники им соотвествуют
         LEFT JOIN employee ON employee.city_id = city.city_id
-- оставлем только те города, для которых сотрудник не найден
WHERE employee IS NULL;


