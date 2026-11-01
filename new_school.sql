CREATE TABLE teachers (
    teacher_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(30),
    hire_date DATE
);
CREATE TABLE classes (
    class_id SERIAL PRIMARY KEY,
    class_name VARCHAR(10) NOT NULL,
    school_year VARCHAR(9) NOT NULL,
    class_teacher_id INTEGER NOT NULL
        REFERENCES teachers(teacher_id),
    UNIQUE (class_name, school_year)
);
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    birth_date DATE NOT NULL,
    class_id INTEGER NOT NULL
        REFERENCES classes(class_id),
    enrollment_date DATE NOT NULL
);
CREATE TABLE subjects (
    subject_id SERIAL PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE lessons (
    lesson_id SERIAL PRIMARY KEY,
    class_id INTEGER NOT NULL REFERENCES classes(class_id),
    teacher_id INTEGER NOT NULL REFERENCES teachers(teacher_id),
    subject_id INTEGER NOT NULL REFERENCES subjects(subject_id),
    day_of_week INTEGER NOT NULL,
    lesson_number VARCHAR(20),
    room VARCHAR(20),
    UNIQUE (class_id, day_of_week, lesson_number)
);
CREATE TABLE grades (
    grade_id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES students(student_id),
    lesson_id INTEGER NOT NULL REFERENCES lessons(lesson_id),
    grade_value INTEGER NOT NULL,
    comment TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE parents (
    parent_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(30)
);
CREATE TABLE student_parents (
    student_id INTEGER NOT NULL REFERENCES students(student_id),
    parent_id INTEGER NOT NULL REFERENCES parents(parent_id),
    relationship VARCHAR(30) NOT NULL,
    PRIMARY KEY (student_id, parent_id)
);

INSERT INTO teachers
    (first_name, last_name, middle_name, email, phone_number, hire_date)
VALUES
('Анна', 'Иванова', 'Викторовна', 'anna.ivanova@example.com', '+7-900-100-0001', '2012-08-20'),
('Марина', 'Петрова', 'Сергеевна', 'marina.petrova@example.com', '+7-900-100-0002', '2015-08-20'),
('Ольга', 'Смирнова', 'Николаевна', 'olga.smirnova@example.com', '+7-900-100-0003', '2011-08-20'),
('Сергей', 'Волков', 'Александрович', 'sergey.volkov@example.com', '+7-900-100-0004', '2009-08-20'),
('Елена', 'Кузнецова', 'Андреевна', 'elena.kuznetsova@example.com', '+7-900-100-0005', '2017-08-20'),
('Дмитрий', 'Соколов', 'Олегович', 'dmitry.sokolov@example.com', '+7-900-100-0006', '2014-08-20'),
('Ирина', 'Морозова', 'Павловна', 'irina.morozova@example.com', '+7-900-100-0007', '2016-08-20'),
('Павел', 'Орлов', 'Игоревич', 'pavel.orlov@example.com', '+7-900-100-0008', '2018-08-20');

INSERT INTO classes
    (class_name, school_year, class_teacher_id)
VALUES
('7А', '2026-2027', 1),
('7Б', '2026-2027', 4);

INSERT INTO subjects (subject_name)
VALUES
('Математика'),
('Русский язык'),
('Литература'),
('История'),
('Английский язык'),
('Биология'),
('География'),
('Информатика');

INSERT INTO students
    (first_name, last_name, birth_date, class_id, enrollment_date)
SELECT
    'Ученик ' || n,
    c.class_name,
    DATE '2013-01-01' + n,
    c.class_id,
    DATE '2020-09-01'

FROM classes AS c
CROSS JOIN generate_series(1, 20) AS gs(n)

WHERE c.class_name IN ('7А', '7Б');

INSERT INTO parents
    (first_name, last_name, email, phone_number)
SELECT
    'Родитель',
    'Ученика ' || s.student_id,
    'parent' || s.student_id || '@example.com',
    '+7-900-200-' || LPAD(s.student_id::TEXT, 4, '0')

FROM students AS s
ORDER BY s.student_id;

INSERT INTO student_parents
    (student_id, parent_id, relationship)
SELECT
    s.student_id,
    p.parent_id,

    CASE
        WHEN s.student_id % 2 = 0 THEN 'Мать'
        ELSE 'Отец'
    END

FROM students AS s

JOIN parents AS p
    ON p.email = 'parent' || s.student_id || '@example.com';

INSERT INTO lessons
    (class_id, teacher_id, subject_id,
     day_of_week, lesson_number, room)
SELECT
    c.class_id,
    ((d.day_no + n.lesson_no + c.class_id - 2) % 8) + 1,
    ((d.day_no + n.lesson_no + c.class_id - 2) % 8) + 1,
    d.day_no,
    n.lesson_no::VARCHAR(20),
    (200 + c.class_id * 100 + n.lesson_no)::VARCHAR(20)

FROM classes AS c

CROSS JOIN generate_series(1, 5) AS d(day_no)
CROSS JOIN generate_series(1, 6) AS n(lesson_no);

INSERT INTO grades
    (student_id, lesson_id, grade_value, comment)
SELECT
    s.student_id,
    l.lesson_id,

    3 + ((s.student_id + l.lesson_id) % 3),

    CASE
        WHEN 3 + ((s.student_id + l.lesson_id) % 3) = 5
            THEN 'Отличная работа'

        WHEN 3 + ((s.student_id + l.lesson_id) % 3) = 4
            THEN 'Хорошая работа'

        ELSE 'Нужно повторить тему'
    END

FROM students AS s

JOIN lessons AS l
    ON l.class_id = s.class_id

WHERE l.day_of_week = 1
  AND l.lesson_number IN ('1', '2');


