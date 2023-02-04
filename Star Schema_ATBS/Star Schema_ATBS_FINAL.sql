-- Dim Tables


-- Customer Dim table

CREATE TABLE Dim_Customer_ATBS(
CustomerKey NUMBER(10),
CustomerName NVARCHAR2(100) NULL,
Address NVARCHAR2(50) NULL,
CityName NVARCHAR2(50) NULL,
ProvinceName NVARCHAR2(5) NULL,
EmailAddress NVARCHAR2(100) NULL,
PhoneNumber NVARCHAR2(20) NULL,
StartDate DATE NOT NULL,
EndDate DATE NULL,
CONSTRAINT Dim_Customer_ATBS_PK PRIMARY KEY ( CustomerKey )
);





-- Flight Dim table


CREATE TABLE Dim_Flights_ATBS(
	FlightKey NUMBER(10) NOT NULL,
	DepartingAirportName nvarchar2(50) NOT NULL,
	ArivingAirportName nvarchar2(50) NOT NULL,
	DepartureGate NUMBER(10) NOT NULL,
	AirplaneNumber NUMBER(10)NOT NULL,
	FuelCost NUMBER(18, 2) NOT NULL,
	FoodCost NUMBER(18, 2) NOT NULL,
	DepartureDate DATE NOT NULL,
	ArivalDate DATE NOT NULL,
	CONSTRAINT Dim_Flights_ATBS_PK PRIMARY KEY (FlightKey)
);



-- Airline Dim table

CREATE TABLE Dim_Airline_ATBS(
AirlineKey NUMBER(10),
AirlineCode NUMBER(10),
AirlineName NVARCHAR2(50) NULL,
StartDate DATE NOT NULL,
EndDate DATE NULL,
CONSTRAINT Dim_Airline_ATBS_PK PRIMARY KEY (AirlineKey )
);

-- Date Dim table

CREATE TABLE Dim_Date_ATBS(
DateKey NUMBER(10),
DateValue DATE NOT NULL,
Year NUMBER(10) NOT NULL,
Month NUMBER(2) NOT NULL,
Day NUMBER(2) NOT NULL,
Quarter NUMBER(1) NOT NULL,
StartOfMonth DATE NOT NULL,
EndOfMonth DATE NOT NULL,
MonthName VARCHAR2(9) NOT NULL,
DayOfWeekName VARCHAR2(9) NOT NULL,
CONSTRAINT Dim_Date_ATBS_PK PRIMARY KEY (DateKey)
);

-- Airplane Dim table

CREATE TABLE Dim_Airplane_ATBS(
AirplaneKey NUMBER(10),
AirplaneType NVARCHAR2(100) NULL,
AirlineCode NUMBER(20) NULL,
FirstSeating NUMBER(20) NULL,
SecondSeating NUMBER(20) NULL,
ThirdSeating NUMBER(20) NULL,
DepartureDate DATE NOT NULL,
ArrivalDate DATE NULL,
CONSTRAINT Dim_Airplane_ATBS_PK PRIMARY KEY ( AirplaneKey )
);


-- Fact table with key values of all Dim tables

CREATE TABLE FactCustomerBooking_ATBS( 
CustomerKey NUMBER(10) NOT NULL,
AirplaneKey NUMBER(10) NOT NULL,
AirlineKey NUMBER(10) NOT NULL,
FlightKey NUMBER(10) NOT NULL,
DateKey NUMBER(10) NOT NULL,
SeatClass nvarchar2(50) NOT NULL,
TicetPrice NUMBER(18, 2) NULL,
TaxRate NUMBER(18,3) NOT NULL,
TotalBeforeTax NUMBER(18,2) NOT NULL,
TotalAfterTax NUMBER(18,2) NOT NULL,
CONSTRAINT FactCustomerBooking_ATBS_CustomerKey_FK FOREIGN KEY (CustomerKey) REFERENCES Dim_Customer_ATBS ( CustomerKey),
CONSTRAINT FactCustomerBooking_ATBS_AirplaneKey_FK  FOREIGN KEY (AirplaneKey) REFERENCES Dim_Airplane_ATBS ( AirplaneKey),
CONSTRAINT FactCustomerBooking_ATBS_AirlineKey_FK  FOREIGN KEY (AirlineKey ) REFERENCES Dim_Airline_ATBS (AirlineKey),
CONSTRAINT FactCustomerBooking_ATBS_FlightKey_FK  FOREIGN KEY (FlightKey  ) REFERENCES Dim_Flights_ATBS (FlightKey),
CONSTRAINT FactCustomerBooking_ATBS_DateKey_FK  FOREIGN KEY (DateKey) REFERENCES Dim_Date_ATBS (DateKey)
);


-- INDEXES

CREATE INDEX FactCustomerBooking_ATBS_CustomerKey_INDEX ON FactCustomerBooking_ATBS(CustomerKey);
CREATE INDEX FactCustomerBooking_ATBS_AirplaneKey_INDEX ON FactCustomerBooking_ATBS(AirplaneKey);
CREATE INDEX FactCustomerBooking_ATBS_AirlineKey_INDEX ON FactCustomerBooking_ATBS(AirlineKey);
CREATE INDEX FactCustomerBooking_ATBS_FlightKey_INDEX ON FactCustomerBooking_ATBS(FlightKey);
CREATE INDEX FactCustomerBooking_ATBS_DateKey_INDEX ON FactCustomerBooking_ATBS(DateKey);






-- Anjan Shah - 8817999
-- Prabhjot Singh - 8752445
-- Savita Sharma - 8735811
-- Kamini Banwala - 8818829