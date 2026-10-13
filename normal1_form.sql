--Задание 1
CREATE TABLE Publishers (
    publisher_id INT PRIMARY KEY,
    publisher_name VARCHAR(255) NOT NULL,
    publisher_city VARCHAR(100) NOT NULL
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_name VARCHAR(255),
    publisher_id INT,

    FOREIGN KEY (publisher_id)
        REFERENCES Publishers(publisher_id)
);
--Задание 2
CREATE TABLE CarModels (
    car_model VARCHAR(100) PRIMARY KEY,
    car_manufacturer VARCHAR(100) NOT NULL
);
CREATE TABLE RaceResults (
    race_id INT,
    driver_id INT,
    car_model VARCHAR(100) NOT NULL,
    finish_time TIME,

    PRIMARY KEY (race_id, driver_id),

    FOREIGN KEY (car_model)
        REFERENCES CarModels(car_model)
);
-- Задание 3
CREATE TABLE EventTypeRooms (
    event_type VARCHAR(50) PRIMARY KEY,
    room_name VARCHAR(100) NOT NULL
);
CREATE TABLE Events (
    event_name VARCHAR(255) PRIMARY KEY,
    event_type VARCHAR(50) NOT NULL,

    FOREIGN KEY (event_type)
        REFERENCES EventTypeRooms(event_type)
);
CREATE TABLE RoomBookings (
    booking_time TIMESTAMP NOT NULL,
    event_name VARCHAR(255) NOT NULL,

    PRIMARY KEY (booking_time, event_name),

    FOREIGN KEY (event_name)
        REFERENCES Events(event_name)
);