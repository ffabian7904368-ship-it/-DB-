--Краткое описание:
--Реляционная схема базы данных библиотеки состоит из пяти таблиц: Reader, Book, Author, Authorship и Issuance.
--Reader — хранит информацию о читателях: идентификатор читателя (reader_id), ФИО (full_name) и номер телефона (phone_number).
--Book — содержит сведения о книгах: ISBN (isbn), название (title) и год издания (year_of_publication).
--Author — хранит информацию об авторах: идентификатор автора (author_id) и ФИО (full_name).
--Authorship — связующая таблица между книгами и авторами. Она реализует связь M:N, так как одна книга может иметь нескольких авторов, а один автор может написать несколько книг.
--Issuance — хранит информацию о выдаче книг читателям: идентификатор выдачи (issuance_id), идентификатор читателя (reader_id), ISBN книги (isbn_book), дату выдачи (date_issue), планируемую дату возврата (planned_return_date) и фактическую дату возврата (actual_return_date).
--Первичные ключи обеспечивают уникальную идентификацию записей, а внешние ключи связывают таблицы между собой и обеспечивают целостность данных.

--Reader: читатель библиотеки
CREATE TABLE Reader (
    reader_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL UNIQUE
);
--Book: книга библиотеки
CREATE TABLE Book (
    isbn VARCHAR(20) PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    year_of_publication INT NOT NULL
);
--Author: автор книги
CREATE TABLE Author (
    author_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL
);
--Authorship: связующая таблица для связи М:N между Book и Author
CREATE TABLE Authorship (
    isbn_book VARCHAR(20) NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (isbn_book, author_id),
    FOREIGN KEY (isbn_book) REFERENCES Book(isbn),
    FOREIGN KEY (author_id) REFERENCES Author(author_id)
);
--Issuance: факт выдачи книги читателю.
CREATE TABLE Issuance (
    issuance_id SERIAL PRIMARY KEY,
    reader_id INT NOT NULL,
    isbn_book VARCHAR(20) NOT NULL,
    FOREIGN KEY (reader_id) REFERENCES Reader(reader_id),
    FOREIGN KEY (isbn_book) REFERENCES Book(isbn),
    date_issue DATE NOT NULL,
    planned_return_date DATE NOT NULL,
    actual_return_date DATE
);

--Читатели
INSERT INTO Reader (full_name, phone_number) VALUES
('Анна Петрова', '+7-900-111-22-33'),
('Иван Соколов', '+7-900-222-33-44'),
('Мария Ким', '+7-900-333-44-55'),
('Олег Васильев', '+7-900-444-55-66');

--Книги
INSERT INTO Book (isbn, title, year_of_publication) VALUES
('978-5-17-118366-8', 'Мастер и Маргарита', 1967),
('978-5-389-06256-6', 'Преступление и наказание', 1866),
('978-5-04-116716-3', 'Война и мир', 1869),
('978-5-699-12014-7', 'Золотой теленок', 1931),
('978-5-389-03713-7', 'Пикник на обочине', 1972);

--Авторы
INSERT INTO Author (full_name) VALUES
('Михаил Булгаков'),
('Федор Достоевский'),
('Лев Толстой'),
('Илья Ильф'),
('Евгений Петров'),
('Аркадий Стругацкий'),
('Борис Стругацкий');

--Авторство
INSERT INTO Authorship (isbn_book, author_id) VALUES
('978-5-17-118366-8', 1),
('978-5-389-06256-6', 2),
('978-5-04-116716-3', 3),
('978-5-699-12014-7', 4),
('978-5-699-12014-7', 5),
('978-5-389-03713-7', 6),
('978-5-389-03713-7', 7);

--Выдачи
INSERT INTO Issuance
    (reader_id, isbn_book, date_issue, planned_return_date, actual_return_date)
VALUES
    (1, '978-5-17-118366-8', '2026-09-01', '2026-09-15', NULL),
    (2, '978-5-389-06256-6', '2026-09-03', '2026-09-17', '2026-09-12'),
    (1, '978-5-04-116716-3', '2026-09-10', '2026-09-24', NULL),
    (3, '978-5-699-12014-7', '2026-08-20', '2026-09-03', '2026-09-01'),
    (4, '978-5-389-03713-7', '2026-09-05', '2026-09-19', NULL),
    (2, '978-5-17-118366-8', '2026-08-01', '2026-08-15', '2026-08-10');

---У Анны Петровой изменился номер телефона
UPDATE Reader
SET phone_number = '+7-900-111-99-00'
WHERE reader_id = 1;

--Одна активная выдача завершилась
UPDATE Issuance
SET actual_return_date = '2026-09-18'
WHERE issuance_id = 1;

--Добавление тестового читателя без выдач
INSERT INTO Reader (full_name, phone_number)
VALUES ('Тестовый Читатель', '+7-900-555-66-77');

--Удаляем читателя без выдач
DELETE FROM Reader
WHERE phone_number = '+7-900-555-66-77';


-- Ввывод:
-- Связь Reader 1: Issuance реализована внешним ключом reader_id (Issuance) - reader_id (Reader)
-- Связь Book 1:M Issuance реализована внешним ключом isbn_book (Issuance) - isbn (Book)
-- Связь Book M:N Author реализована через Authorship: (Authorship) isbn_book - (Book) isbn - (Authorship) author_id - (Author) author_id
