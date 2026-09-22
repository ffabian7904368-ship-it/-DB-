--1
SELECT * 
FROM Reader;
--2
SELECT title, year_of_publication 
FROM Book;
--3
SELECT title, year_of_publication 
FROM Book 
WHERE year_of_publication BETWEEN 1801 AND 1900;
--4
SELECT title, year_of_publication 
FROM Book 
WHERE year_of_publication BETWEEN 1917 AND 1991;
--5
SELECT * 
FROM Reader
WHERE phone_number = '+7-900-111-22-33';
--6
SELECT *
FROM Reader
WHERE full_name LIKE '%ов%';
--7
SELECT *
FROM Issuance
WHERE actual_return_date IS NULL;
--8
SELECT title, year_of_publication
FROM Book
ORDER BY title ASC;
--9
SELECT *
FROM Issuance
WHERE actual_return_date IS NULL
ORDER BY planned_return_date ASC;
--10
SELECT title, year_of_publication
FROM Book
ORDER BY year_of_publication ASC
LIMIT 3;