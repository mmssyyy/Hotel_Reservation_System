DROP TABLE reservation_info;

CREATE TABLE reservation_info (
    reservation_id VARCHAR(255)PRIMARY KEY,
    customer_id VARCHAR(255),
    hotel_id VARCHAR(255),
    room_price INT,
    customer_name VARCHAR(255),
    room_type VARCHAR(50),
    number_of_guests INT,
    start_date DATE,
    end_date DATE,
    reservation_status VARCHAR(20)
);