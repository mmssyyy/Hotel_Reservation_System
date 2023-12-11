CREATE TABLE hotel_info (
    hotel_id NUMBER PRIMARY KEY,
    hotel_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    location VARCHAR(255),
    number_of_rooms INT
);

-- 시퀀스 생성
CREATE SEQUENCE reservation_sequence
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;

-- reservation_info 테이블 생성
CREATE TABLE reservation_info (
    reservation_id NUMBER PRIMARY KEY,
    customer_id NUMBER, -- 고객 정보 테이블과의 연결
    hotel_id NUMBER, -- 호텔 정보 테이블과의 연결
    room_price NUMBER, -- 객실 가격 (FK, 호텔 정보와 연계)
    room_number VARCHAR2(10),
    number_of_guests NUMBER,
    start_date DATE,
    end_date DATE,
    reservation_status VARCHAR2(20),
    CONSTRAINT fk_hotel FOREIGN KEY (hotel_id) REFERENCES hotel_info(hotel_id),
    CONSTRAINT fk_room_price FOREIGN KEY (room_price) REFERENCES hotel_info(room_price)
);