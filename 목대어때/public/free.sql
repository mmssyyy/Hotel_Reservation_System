DROP TABLE FacilityDetails;

CREATE TABLE FacilityDetails(
    FacilityDetailID INT PRIMARY KEY,    
    HotelID VARCHAR(100),
    Facility_id VARCHAR(100),              
    FacilityID INT,                   
    FacilityType VARCHAR(50),           
    FacilityDescription VARCHAR(500),   
    AvailableHours VARCHAR(100),         
    FacilityPrice DECIMAL(10, 2),       
    ReservationRequired CHAR(1)         
);  