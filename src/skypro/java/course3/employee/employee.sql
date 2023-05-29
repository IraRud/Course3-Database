-- [Введение в базы данных и SQL]

-- БД skypro уже создана во время урока
-- CREATE DATABASE skypro;

-- Создайте таблицу employee с столбцами:
CREATE TABLE employee
(
    id         BIGSERIAL   NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    gender     VARCHAR(6)  NOT NULL,
    age        INT         NOT NULL
);
-- [Работа с несколькими таблицами:
-- после создания связи с таблицей city добавлено новое поле внешнего ключа city_id
-- employee - дочерняя/зависимая таблица, связь: One to Many]

-- Добавьте в таблицу 3 записи
-- встаяляем данные без id, генерируется самостоятельно
INSERT INTO employee(first_name, last_name, gender, age)
VALUES ('Киллиан', 'Мерфи', 'муж.', 46),
       ('Скарлетт', 'Йоханссон', 'жен.', 38),
       ('Мэтт', 'Леблан', 'муж.', 54);

-- Получите все записи из базы
SELECT *
FROM employee;

-- Измените одну запись полностью
UPDATE employee
SET first_name = 'Мэттью',
    last_name  = 'Перри',
    gender     = 'муж.',
    age        = 53
WHERE first_name = 'Мэтт';

SELECT *
FROM employee;

-- Удалите одну запись из базы
DELETE
FROM employee
WHERE id = 2;

SELECT *
FROM employee;

-- [Выборка данных и вложенные запросы]

-- доведите количество записей в таблице до 5
INSERT INTO employee(first_name, last_name, gender, age)
VALUES ('Дженнифер', 'Энистон', 'жен.', 54),
       ('Скарлетт', 'Йоханссон', 'жен.', 38),
       ('Джису', 'Ким', 'жен.', 28);

-- получите информацию об именах и фамилиях по всем сотрудникам. Колонки должны называться «Имя» и «Фамилия»
SELECT first_name AS Имя,
       last_name  AS Фамилия
FROM employee;

-- получите всю информацию о сотрудниках, которые младше 30 или старше 50 лет
SELECT *
FROM employee
WHERE age < 30
   OR age > 50;

-- получите всю информацию о сотрудниках, которым от 30 до 50 лет
SELECT *
FROM employee
WHERE age BETWEEN 30 and 50;

-- выведите полный список сотрудников, которые отсортированы по фамилиям в обратном порядке
SELECT first_name AS Имя,
       last_name  AS Фамилия
FROM employee
ORDER BY last_name DESC;

-- выведите сотрудников, имена которых длиннее 4 символов
SELECT first_name AS Имя,
       last_name  AS Фамилия
FROM employee
WHERE first_name LIKE '_____%';

-- измените имена у двух сотрудников так, чтобы на 5 сотрудников было только 3 разных имени, то есть чтобы
-- получились две пары тезок и один сотрудник с уникальным именем
UPDATE employee
SET first_name = 'Дженнифер'
WHERE first_name = 'Джису';

UPDATE employee
SET first_name = 'Киллиан'
WHERE first_name = 'Мэттью';

SELECT *
FROM employee;

-- посчитайте суммарный возраст для каждого имени. Выведите в двух столбцах «имя» и «суммарный возраст»
SELECT first_name AS Имя,
       SUM(age)   AS Суммарный_возраст
FROM employee
GROUP BY first_name;

-- выведите имя и самый юный возраст, соответствующий имени (несколько одинаковых имен)
SELECT first_name AS Имя,
       MIN(age) AS Min_возраст
FROM employee
GROUP BY first_name;

-- выведите имя и максимальный возраст только для неуникальных имен. Результат отсортируйте по возрасту
-- в порядке возрастания
SELECT first_name AS Имя,
       MAX(age)   AS Максимальный_возраст
FROM employee
GROUP BY first_name
HAVING COUNT(first_name) > 1
-- age должен быть либо агрегирован, либо указан в предложении GROUP BY
ORDER BY MAX(age);
