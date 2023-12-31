--고객 테이블
CREATE TABLE users (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR2(100),
    email VARCHAR2(100),
    phone VARCHAR2(100),
    birth DATE,
    address VARCHAR2(255),
    passwd VARCHAR2(100),
    PRIMARY KEY (id)
);


--고객 관리 테이블
CREATE TABLE USER_MANAGEMENT (
    CustomerID INT PRIMARY KEY,
    Username VARCHAR(50),
    Name VARCHAR(100),
    Birthdate VARCHAR(6),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(255),
    MembershipLevel VARCHAR(50),
    Notes VARCHAR(50)
);

CREATE TABLE USER_REVIEW (
    ReviewID INT PRIMARY KEY,
    CustomerID INT,
    HotelID INT,
    Rating INT,
    ReviewContent VARCHAR2(255),
    FOREIGN KEY (CustomerID) REFERENCES users(ID)
);



--부대시설 상세정보
CREATE TABLE FacilityDetails(
    FacilityDetailID INT PRIMARY KEY,    
    HotelID VARCHAR(100),
    Facility_id VARCHAR(100),              
    customername INT,                   
    FacilityType VARCHAR(50),           
    FacilityDescription VARCHAR(500),   
    AvailableHours VARCHAR(100),         
    FacilityPrice DECIMAL(10, 2),       
    ReservationRequired CHAR(1)         
);   

--부대시설 예약
CREATE TABLE FacilityReservation (
    f_ReservationID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    Hotelname VARCHAR(100),33
    Reservationprice DECIMAL(10, 2),
    FacilityType VARCHAR(255),
    NumberOfPeople INT,
    StartDate DATE,
    EndDate DATE,
    ReservationStatus VARCHAR(100)
);



--호텔 정보 테이블
CREATE TABLE hotel_info (
    hotel_id NUMBER PRIMARY KEY,
    hotel_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    location VARCHAR(255),
    number_of_rooms INT
);

--예약 관리 테이블
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

DROP TABLE FacilityDetails;

--객실 정보 테이블
CREATE TABLE ROOM (
    RoomTypeID INT PRIMARY KEY,
    HotelID INT,
    RoomType VARCHAR(255),
    RoomPrice DECIMAL(10, 2),
    FOREIGN KEY (HotelID) REFERENCES Hotel_info(Hotel_ID)
);

--호텔 부대시설 테이블
CREATE TABLE HotelFacilities (
    HotelFacilityID INT PRIMARY KEY,
    HotelID INT,
    FacilityID INT,
    FOREIGN KEY (HotelID) REFERENCES Hotel_info(Hotel_ID),
    FOREIGN KEY (FacilityID) REFERENCES Facilityinfo(FacilityID)
);

--부대시설 정보 테이블
CREATE TABLE FacilityInfo (
    FacilityID INT PRIMARY KEY,
    WiFi VARCHAR(20),
    SwimmingPool VARCHAR(20),
    ParkingLot VARCHAR(20),
    BanquetHall VARCHAR(20),
    Restaurant VARCHAR(20),
    Gym VARCHAR(20),
    Karaoke VARCHAR(20),
    SportsFacility VARCHAR(20)
);

--결제 관리 테이블
CREATE TABLE BILL (
    BILL_ID INT PRIMARY KEY,
    ReservationID INT,
    FacilityReservationID INT,
    CustomerID INT,
    PaymentDateTime TIMESTAMP,
    PaymentAmount DECIMAL(10, 2),
    FOREIGN KEY (ReservationID) REFERENCES Room(RoomTypeID),
    FOREIGN KEY (FacilityReservationID) REFERENCES FacilityReservation(f_ReservationID),
    FOREIGN KEY (CustomerID) REFERENCES users(ID)
);


INSERT INTO USER_REVIEW (ReviewID, CustomerID, HotelID, Rating, ReviewContent) VALUES (10000, 84, 10, 5, '친절해요');
INSERT INTO USER_REVIEW (ReviewID, CustomerID, HotelID, Rating, ReviewContent) VALUES (10001, 84, 10, 4, '좋아요');
INSERT INTO USER_REVIEW (ReviewID, CustomerID, HotelID, Rating, ReviewContent) VALUES (10002, 21, 20, 4, '좋아요');
INSERT INTO USER_REVIEW (ReviewID, CustomerID, HotelID, Rating, ReviewContent) VALUES (10003, 21, 30, 5, '친절해요');
INSERT INTO USER_REVIEW (ReviewID, CustomerID, HotelID, Rating, ReviewContent) VALUES (10004, 1, 20, 3, '친절해요');
INSERT INTO USER_REVIEW (ReviewID, CustomerID, HotelID, Rating, ReviewContent) VALUES (10005, 1, 30, 4, '좋아요');

INSERT INTO USER_MANAGEMENT (CustomerID, Username, Name, Birthdate, Phone, Email, Address, MembershipLevel, Notes) 
VALUES (100003, 'user01', '김철수', '850912', '010-9876-5432', 'user01@mail.com', '서울시 강남구 도곡동', 'Gold', '-');
INSERT INTO USER_MANAGEMENT (CustomerID, Username, Name, Birthdate, Phone, Email, Address, MembershipLevel, Notes) 
VALUES (100004, 'user02', '이영희', '920615', '010-5678-1234', 'user02@mail.com', '부산시 해운대구', 'Silver', '-');
INSERT INTO USER_MANAGEMENT (CustomerID, Username, Name, Birthdate, Phone, Email, Address, MembershipLevel, Notes) 
VALUES (100005, 'user03', '박민수', '730708', '010-4567-7890', 'user03@mail.com', '대구시 중구 남산동', 'Bronze', '-');
INSERT INTO USER_MANAGEMENT (CustomerID, Username, Name, Birthdate, Phone, Email, Address, MembershipLevel, Notes) 
VALUES (100006, 'user04', '정다혜', '880403', '010-3210-6547', 'user04@mail.com', '광주시 서구 치평동', 'VIP', '-');
INSERT INTO USER_MANAGEMENT (CustomerID, Username, Name, Birthdate, Phone, Email, Address, MembershipLevel, Notes) 
VALUES (100007, 'user05', '최진영', '950121', '010-1357-2468', 'user05@mail.com', '인천시 남동구 구월동', 'Platinum', '-');

INSERT INTO ROOM  (RoomTypeID, HotelID, RoomType, RoomPrice) VALUES (1, 1, '싱글룸', 100000);
INSERT INTO ROOM  (RoomTypeID, HotelID, RoomType, RoomPrice) VALUES (2, 2, '더블룸', 150000);
INSERT INTO ROOM  (RoomTypeID, HotelID, RoomType, RoomPrice) VALUES (3, 3, '스위트룸', 250000);
INSERT INTO ROOM  (RoomTypeID, HotelID, RoomType, RoomPrice) VALUES (4, 2, '디럭스룸', 200000);
INSERT INTO ROOM  (RoomTypeID, HotelID, RoomType, RoomPrice) VALUES (5, 1, '패밀리룸', 180000);

INSERT INTO HotelFacilities (HotelFacilityID, HotelID, FacilityID) VALUES (101, 1, 10);
INSERT INTO HotelFacilities (HotelFacilityID, HotelID, FacilityID) VALUES (102, 3, 11);
INSERT INTO HotelFacilities (HotelFacilityID, HotelID, FacilityID) VALUES (103, 2, 12);
INSERT INTO HotelFacilities (HotelFacilityID, HotelID, FacilityID) VALUES (104, 1, 13);
INSERT INTO HotelFacilities (HotelFacilityID, HotelID, FacilityID) VALUES (105, 3, 14);

INSERT INTO FacilityInfo (FacilityID, WiFi, SwimmingPool, ParkingLot, BanquetHall, Restaurant, Gym, Karaoke, SportsFacility) 
VALUES (10, 'TRUE', 'FALSE', 'TRUE', 'TRUE', 'TRUE', 'FALSE', 'FALSE', 'FALSE');
INSERT INTO FacilityInfo (FacilityID, WiFi, SwimmingPool, ParkingLot, BanquetHall, Restaurant, Gym, Karaoke, SportsFacility)
 VALUES (11, 'TRUE', 'TRUE', 'TRUE', 'FALSE', 'TRUE', 'TRUE', 'FALSE', 'TRUE');
INSERT INTO FacilityInfo (FacilityID, WiFi, SwimmingPool, ParkingLot, BanquetHall, Restaurant, Gym, Karaoke, SportsFacility) 
VALUES (12, 'TRUE', 'FALSE', 'FALSE', 'TRUE', 'FALSE', 'TRUE', 'TRUE', 'FALSE');
INSERT INTO FacilityInfo (FacilityID, WiFi, SwimmingPool, ParkingLot, BanquetHall, Restaurant, Gym, Karaoke, SportsFacility) 
VALUES (13, 'FALSE', 'TRUE', 'TRUE', 'FALSE', 'TRUE', 'FALSE', 'TRUE', 'TRUE');
INSERT INTO FacilityInfo (FacilityID, WiFi, SwimmingPool, ParkingLot, BanquetHall, Restaurant, Gym, Karaoke, SportsFacility) 
VALUES (14, 'TRUE', 'TRUE', 'FALSE', 'TRUE', 'TRUE', 'FALSE', 'FALSE', 'TRUE');

INSERT INTO BILL (BILL_ID, ReservationID, FacilityReservationID, CustomerID, PaymentDateTime, PaymentAmount) 
VALUES (1, null, 287, 84, TO_DATE('2023-01-05 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100000);
INSERT INTO BILL (BILL_ID, ReservationID, FacilityReservationID, CustomerID, PaymentDateTime, PaymentAmount) 
VALUES (2, null, 287, 84, TO_DATE('2023-01-03 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 150000);
INSERT INTO BILL (BILL_ID, ReservationID, FacilityReservationID, CustomerID, PaymentDateTime, PaymentAmount) 
VALUES (3, 3, null, 21, TO_DATE('2023-01-02 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 200000);
INSERT INTO BILL (BILL_ID, ReservationID, FacilityReservationID, CustomerID, PaymentDateTime, PaymentAmount)
 VALUES (4, null, 482, 1, TO_DATE('2023-01-04 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 250000);
INSERT INTO BILL (BILL_ID, ReservationID, FacilityReservationID, CustomerID, PaymentDateTime, PaymentAmount) 
VALUES (5, null, 482, 21, TO_DATE('2023-01-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 300000);

INSERT INTO FacilityDetails (FacilityDetailID, Hotelid, Facility_ID, CustomerName, FacilityType, FacilityDescription, AvailableHours, FacilityPrice, ReservationRequired) 
VALUES (1, '제주 글로스터 호텔', '10', 101, '헬스클럽', '건강한 라이프스타일을 위한 헬스장 시설입니다.', '06:00 - 22:00', 10000.0, 'Y');
INSERT INTO FacilityDetails (FacilityDetailID, Hotelid, Facility_ID, CustomerName, FacilityType, FacilityDescription, AvailableHours, FacilityPrice, ReservationRequired)
 VALUES (2, '제주 글로스터 호텔', '10', 102, '수영장', '제주 글로스터 호텔 수영장: 넓은 수영장에서 휴식을 취하세요.', '09:00 - 18:00', 40000.0, 'N');
INSERT INTO FacilityDetails (FacilityDetailID, Hotelid, Facility_ID, CustomerName, FacilityType, FacilityDescription, AvailableHours, FacilityPrice, ReservationRequired) 
VALUES (3, '서울 그랜드 하얏트 호텔', '11', 103, '노래방', '재밌게 즐길 수 있는 노래방 시설입니다.', '09:00 - 21:00', 10000.0, 'Y');
INSERT INTO FacilityDetails (FacilityDetailID, Hotelid, Facility_ID, CustomerName, FacilityType, FacilityDescription, AvailableHours, FacilityPrice, ReservationRequired)
 VALUES (4, '서울 그랜드 하얏트 호텔', '11', 104, '레스토랑', '다양한 음식이 뷔페식으로 준비되어있는 고급 레스토랑입니다.', '07:00 - 23:00', 50000.0, 'N');
INSERT INTO FacilityDetails (FacilityDetailID, Hotelid, Facility_ID, CustomerName, FacilityType, FacilityDescription, AvailableHours, FacilityPrice, ReservationRequired) 
VALUES (5, '홀리데이 인 광주호텔', '13', 105, '연회장', '여러 행사가 가능한 연회장입니다.', '예약 기준', 800000.0, 'Y');
INSERT INTO FacilityDetails (FacilityDetailID, Hotelid, Facility_ID, CustomerName, FacilityType, FacilityDescription, AvailableHours, FacilityPrice, ReservationRequired) 
VALUES (6, '홀리데이 인 광주호텔', '13', 106, '비즈니스 센터', '업무를 위한 비즈니스 센터', '24시간 운영', 0.0, 'N');
INSERT INTO FacilityDetails (FacilityDetailID, Hotelid, Facility_ID, CustomerName, FacilityType, FacilityDescription, AvailableHours, FacilityPrice, ReservationRequired)
 VALUES (7, '제주 글로스터 호텔', '10', 107, '연회장', '기업 세미나나 연회에 적합한 고급 연회장입니다.', '예약 기준', 500000.0, 'N');