--Задание 1 
CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(255) NOT NULL
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL
);

CREATE TABLE ProjectTeamMembers (
    project_id INT NOT NULL,
    employee_id INT NOT NULL,

    PRIMARY KEY (project_id, employee_id),

    FOREIGN KEY (project_id)
        REFERENCES Projects(project_id),

    FOREIGN KEY (employee_id)
        REFERENCES Employees(employee_id)
);
--Задание 2
CREATE TABLE Clients (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(255) NOT NULL,
    client_email VARCHAR(255) NOT NULL
);
CREATE TABLE Equipment (
    equipment_id INT PRIMARY KEY,
    equipment_name VARCHAR(255) NOT NULL
);
CREATE TABLE EquipmentRentals (
    client_id INT NOT NULL,
    equipment_id INT NOT NULL,
    rental_date DATE NOT NULL,

    PRIMARY KEY (client_id, equipment_id),

    FOREIGN KEY (client_id)
        REFERENCES Clients(client_id),

    FOREIGN KEY (equipment_id)
        REFERENCES Equipment(equipment_id)
);

--Задание 3

CREATE TABLE StudentCourseGrades_1NF (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    student_name VARCHAR(255) NOT NULL,
    course_professor VARCHAR(255) NOT NULL,
    assignment_name VARCHAR(255) NOT NULL,
    grade NUMERIC(5, 2) NOT NULL,

    PRIMARY KEY (student_id, course_id, assignment_name)
);
--Задание 3
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(255) NOT NULL
);
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_professor VARCHAR(255) NOT NULL
);
CREATE TABLE CourseAssignments (
    assignment_id INT PRIMARY KEY,
    course_id INT NOT NULL,
    assignment_name VARCHAR(255) NOT NULL,

    UNIQUE (course_id, assignment_name),

    FOREIGN KEY (course_id)
        REFERENCES Courses(course_id)
);
CREATE TABLE StudentGrades (
    student_id INT NOT NULL,
    assignment_id INT NOT NULL,
    grade NUMERIC(5, 2) NOT NULL,

    PRIMARY KEY (student_id, assignment_id),

    FOREIGN KEY (student_id)
        REFERENCES Students(student_id),

    FOREIGN KEY (assignment_id)
        REFERENCES CourseAssignments(assignment_id)
)