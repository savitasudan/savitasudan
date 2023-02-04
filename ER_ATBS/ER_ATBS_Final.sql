-- Create Customer Table

CREATE TABLE Customer_ATBS(
	Customer_ID NUMBER(10) NOT NULL,
	Customer_Name nvarchar2(100) NOT NULL,
	Customer_Address nvarchar2(100) NOT NULL,
	Customer_City nvarchar2(100) NOT NULL,
	Customer_State nvarchar2(100) NOT NULL,
	Customer_Birthdate DATE NOT NULL,
	Customer_Phone NUMBER(10) NOT NULL,
	Customer_Email nvarchar2(100) NOT NULL,
 	CONSTRAINT Customer_ID_PK PRIMARY KEY (Customer_ID),
	CONSTRAINT Customer_CustomerName_UQ UNIQUE (Customer_Name)
);

-- Create Airline Table

CREATE TABLE Airline_ATBS(
	Airline_Code NUMBER(10) NOT NULL,
	Airline_Name nvarchar2(50) NOT NULL,
     CONSTRAINT Airline_PK PRIMARY KEY (Airline_Code),
	CONSTRAINT Airline_UQ UNIQUE (Airline_Name)
);

-- Create Airport Table
CREATE TABLE Airport_ATBS(
	Airport_Code NUMBER(10) NOT NULL,
	Airport_Name nvarchar2(50) NOT NULL,
     CONSTRAINT Airport_PK PRIMARY KEY (Airport_Code),
	CONSTRAINT Airport_UQ UNIQUE (Airport_Name)
);

-- Create Tickets Table

CREATE TABLE Tickets_ATBS(
	Ticket_Number NUMBER(10) NOT NULL,
	Ticket_Date DATE NOT NULL,
	Ticket_Price NUMBER(18, 2) NULL,
	Customer_ID NUMBER(10) NOT NULL,
	Customer_Name nvarchar2(100) NOT NULL,
	Ticket_Status nvarchar2(100) NOT NULL,
     CONSTRAINT Tickets_PK PRIMARY KEY (Ticket_Number),
	CONSTRAINT Tickets_FK FOREIGN KEY(Customer_ID) REFERENCES Customer_ATBS (Customer_ID)
);

-- Create Airplane Table

CREATE TABLE Airplane_ATBS(
	Airplane_Number NUMBER(10)NOT NULL,
	Airplane_Type nvarchar2(20) NOT NULL,
	Airline_Code NUMBER(10) NOT NULL,
	First_Class_Seats NUMBER(5) NOT NULL,
	Business_Class_Seats NUMBER(5) NOT NULL,
	Economy_Class_Seats NUMBER(5) NOT NULL,
    CONSTRAINT Airplane_Number_PK PRIMARY KEY (Airplane_Number),
	CONSTRAINT Airplane_FK FOREIGN KEY(Airline_Code) REFERENCES Airline_ATBS (Airline_Code)
);

-- Create Flights Table

CREATE TABLE Flights_ATBS(
	Flight_Number NUMBER(10) NOT NULL,
	Departing_Airport_Code NUMBER(10) NOT NULL,
	Departing_Airport_Name nvarchar2(50) NOT NULL,
	Ariving_Airport_Code NUMBER(10) NOT NULL,
	Ariving_Airport_Name nvarchar2(50) NOT NULL,
	Departure_Gate NUMBER(10) NOT NULL,
	Arival_Gate NUMBER(10) NOT NULL,
	Airplane_Number NUMBER(10)NOT NULL,
	Fuel_Cost NUMBER(18, 2) NOT NULL,
	Food_Cost NUMBER(18, 2) NOT NULL,
	Departure_Date DATE NOT NULL,
	Arival_Date DATE NOT NULL,
	CONSTRAINT Flights_PK PRIMARY KEY (Flight_Number),
	CONSTRAINT Flights_AirplaneNumber_FK FOREIGN KEY(Airplane_Number) REFERENCES Airplane_ATBS (Airplane_Number),
	CONSTRAINT Flights_ArivingAirportCode_FK FOREIGN KEY(Ariving_Airport_Code) REFERENCES Airport_ATBS (Airport_Code),
	CONSTRAINT Flights_ArivingAirportName_FK FOREIGN KEY(Ariving_Airport_Name) REFERENCES Airport_ATBS (Airport_Name),
	CONSTRAINT Flights_DepartingAirportCode_FK FOREIGN KEY(Departing_Airport_Code) REFERENCES Airport_ATBS (Airport_Code),
	CONSTRAINT Flights_DepartingAirportName_FK FOREIGN KEY(Departing_Airport_Name) REFERENCES Airport_ATBS (Airport_Name)
);

-- Create CustomerBooking Table

CREATE TABLE CustomerBooking_ATBS(
	Booking_ID NUMBER(10) NOT NULL,
	Ticket_Number NUMBER(10) NOT NULL,
	Flight_Number NUMBER(10) NOT NULL,
	Customer_ID NUMBER(10) NOT NULL,
	Seat_Number NUMBER(10) NOT NULL,
	Ticket_Price NUMBER(18, 2) NULL,
	Seat_Class nvarchar2(50) NOT NULL,
	CONSTRAINT CustomerBooking_PK PRIMARY KEY (Booking_ID),
	CONSTRAINT CustomerBooking_CustomerID_FK FOREIGN KEY(Customer_ID) REFERENCES Customer_ATBS (Customer_ID),
	CONSTRAINT CustomerBooking_FlightNumber_FK FOREIGN KEY(Flight_Number) REFERENCES Flights_ATBS (Flight_Number)
);






-- Anjan Shah - 8817999
-- Prabhjot Singh - 8752445
-- Savita Sharma - 8735811
-- Kamini Banwala - 8818829