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
