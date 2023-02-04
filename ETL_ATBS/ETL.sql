
-- Date Load

CREATE OR REPLACE PROCEDURE Dim_Date_Value ( DateValue IN DATE )
AS
BEGIN
INSERT INTO Dim_Date_ATBS
SELECT
EXTRACT(YEAR FROM DateValue) * 10000 + EXTRACT(Month FROM DateValue) * 100 + EXTRACT(Day FROM DateValue) DateKey
,DateValue DateValue
,EXTRACT(YEAR FROM DateValue) CurrentYear
,CAST(TO_CHAR(DateValue, 'Q') AS INT) CurrentQuarter
,EXTRACT(Month FROM DateValue) CurrentMonth
,EXTRACT(Day FROM DateValue) CurrentDay
,TRUNC(DateValue) - (TO_NUMBER (TO_CHAR(DateValue,'DD')) - 1) StartOfMonth
,ADD_Months(TRUNC(DateValue) - (TO_NUMBER(TO_CHAR(DateValue,'DD')) - 1), 1) -1 EndOfMonth
,TO_CHAR(DateValue, 'MONTH') MonthName
,TO_CHAR(DateValue, 'DY') DayOfWeekName
FROM dual;
END;

-- data of DimDate table before loading value 
select * from Dim_Date_ATBS;

--make 'YYYY-MM-DD' as a default date format to pass value
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';

-- Execute procedure
EXECUTE Dim_Date_Value(2019-10-16);

BEGIN
Dim_Date_Value('2019-10-16');
END;


-- Load stage table from dataset


-- Stage Table For Customer


CREATE TABLE Customer_Stage_ATBS (
CustomerName nvarchar2(100),
CustomerAddress nvarchar2(100),
CustomerCity nvarchar2(100),
CustomerState nvarchar2(100),
CustomerBirthdate DATE,
CustomerPhone NUMBER(10),
CustomerEmail NVARCHAR2(100) NULL
);

-- PROCEDURE TO INSERT DATA INTO TABLE

CREATE OR REPLACE PROCEDURE Customer_Extract_ATBS
AS
    RowCt NUMBER(10);
    temp_sql VARCHAR(255) := 'TRUNCATE TABLE Customer_Stage_ATBS DROP STORAGE';
BEGIN
    EXECUTE IMMEDIATE temp_sql;
    
    INSERT INTO Customer_Stage_ATBS 
    SELECT  c.Customer_ID,c.Customer_Name,c.Customer_City,c.Customer_State,c.Customer_Birthdate,c.Customer_Phone,c.Customer_Email
    FROM Customer_ATBS c;
	 
--EXCEPTION TO CHECK WHETHER THE DATA HAS BEEN INSERTED OR NOT
    RowCt := SQL%ROWCOUNT;
    IF sql%notfound THEN
       dbms_output.put_line('No data found!!');
    ELSIF sql%found THEN
       dbms_output.put_line(TO_CHAR(RowCt) ||' Data inserted!');
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
       dbms_output.put_line(SQLERRM);
       dbms_output.put_line(temp_sql);
END;


-- DISPLAY THE PRINT LINE IN THE OUTPUT
SET SERVEROUT ON;
TRUNCATE TABLE Customer_Stage_ATBS;

-- INSERT DATA INTO ABOVE CREATED TABLE VIA PROCEDURE 'Customer_Extract_ATBS' 
EXECUTE Customer_Extract_ATBS;
SELECT * FROM Customer_Stage_ATBS;



-- Stage Table For Airplane



CREATE TABLE Airplane_Stage_ATBS (
AirplaneNumber NUMBER(10),
AirplaneType nvarchar2(20),
AirlineCode NUMBER(10),
FirstClassSeats NUMBER(5),
BusinessClassSeats NUMBER(5),
EconomyClassSeats NUMBER(5)
);

-- PROCEDURE TO INSERT DATA INTO TABLE

CREATE OR REPLACE PROCEDURE Airplane_Extract_ATBS
AS
    RowCt NUMBER(10);
    temp_sql VARCHAR(255) := 'TRUNCATE TABLE Airplane_Stage_ATBS DROP STORAGE';
BEGIN
    EXECUTE IMMEDIATE temp_sql;
    
    INSERT INTO Airplane_Stage_ATBS 
    SELECT  a.Airplane_Number,a.Airplane_Type,a.Airline_Code,a.First_Class_Seats,a.Business_Class_Seats,a.Economy_Class_Seats 
    FROM Airplane_ATBS a;
	 
--EXCEPTION TO CHECK ABOVE DATA INSERTION
    RowCt := SQL%ROWCOUNT;
    IF sql%notfound THEN
       dbms_output.put_line('No DATA FOUND!');
    ELSIF sql%found THEN
       dbms_output.put_line(TO_CHAR(RowCt) ||' Data Loaded');
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
       dbms_output.put_line(SQLERRM);
       dbms_output.put_line(temp_sql);
END;


-- DISPLAY THE PRINT LINE IN THE OUTPUT
SET SERVEROUT ON;
TRUNCATE TABLE Airplane_Stage_ATBS;

-- INSERT DATA INTO ABOVE CREATED TABLE VIA PROCEDURE 'Airplane_Extract_ATBS' 
EXECUTE Airplane_Extract_ATBS;
SELECT * FROM Airplane_Stage_ATBS;




-- Stage Table For Airport



CREATE TABLE Airport_Stage_ATBS (
AirportCode NUMBER(10),
AirportName nvarchar2(50)
);



-- PROCEDURE TO INSERT DATA INTO TABLE

CREATE OR REPLACE PROCEDURE Airport_Extract_ATBS
AS
    RowCt NUMBER(10);
    temp_sql VARCHAR(255) := 'TRUNCATE TABLE Airport_Stage_ATBS DROP STORAGE';
BEGIN
    EXECUTE IMMEDIATE temp_sql;
    
    INSERT INTO Airport_Stage_ATBS 
    SELECT  ap.Airport_Code,ap.Airport_Name
    FROM Airport_ATBS ap;
	 
--EXCEPTION TO CHECK ABOVE DATA INSERTION
    RowCt := SQL%ROWCOUNT;
    IF sql%notfound THEN
       dbms_output.put_line('No DATA FOUND!');
    ELSIF sql%found THEN
       dbms_output.put_line(TO_CHAR(RowCt) ||' Data Loaded');
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
       dbms_output.put_line(SQLERRM);
       dbms_output.put_line(temp_sql);
END;


-- DISPLAY THE PRINT LINE IN THE OUTPUT
SET SERVEROUT ON;
TRUNCATE TABLE Airport_Stage_ATBS;

-- INSERT DATA INTO ABOVE CREATED TABLE VIA PROCEDURE 'Airport_Extract_ATBS'
EXECUTE Airport_Extract_ATBS;
SELECT * FROM Airport_Stage_ATBS;






-- Stage Table For Airline




CREATE TABLE Airline_Stage_ATBS (
AirlineCode NUMBER(10),
AirlineName nvarchar2(50)
);

-- PROCEDURE TO INSERT DATA INTO TABLE

CREATE OR REPLACE PROCEDURE Airline_Extract_ATBS
AS
    RowCt NUMBER(10);
    temp_sql VARCHAR(255) := 'TRUNCATE TABLE Airline_Stage_ATBS DROP STORAGE';
BEGIN
    EXECUTE IMMEDIATE temp_sql;
    
    INSERT INTO Airline_Stage_ATBS 
    SELECT  al.Airline_Code,al.Airline_Name
    FROM Airline_ATBS al;
	 
--EXCEPTION TO CHECK ABOVE DATA INSERTION
    RowCt := SQL%ROWCOUNT;
    IF sql%notfound THEN
       dbms_output.put_line('No DATA FOUND!');
    ELSIF sql%found THEN
       dbms_output.put_line(TO_CHAR(RowCt) ||' Data Loaded');
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
       dbms_output.put_line(SQLERRM);
       dbms_output.put_line(temp_sql);
END;


-- DISPLAY THE PRINT LINE IN THE OUTPUT
SET SERVEROUT ON;
TRUNCATE TABLE Airline_Stage_ATBS;

-- INSERT DATA INTO ABOVE CREATED TABLE VIA PROCEDURE 'Airline_Extract_ATBS'
EXECUTE Airline_Extract_ATBS;
SELECT * FROM Airline_Stage_ATBS;




-- Stage Table For Flight



CREATE TABLE Flight_Stage_ATBS (
FlightID NUMBER(10) NOT NULL,
DepartAirportCode NUMBER(10) NOT NULL,
DepartAirportName nvarchar2(50) NOT NULL,
ArivalAirportCode NUMBER(10) NOT NULL,
ArivalAirportName nvarchar2(50) NOT NULL,
DepartureGate NUMBER(10) NOT NULL,
ArivalGate NUMBER(10) NOT NULL,
AirplaneNumber NUMBER(10)NOT NULL,
FuelCost NUMBER(18, 2) NOT NULL,
FoodCost NUMBER(18, 2) NOT NULL,
DepartureDate DATE NOT NULL,
ArivalDate DATE NOT NULL
);

-- PROCEDURE TO INSERT DATA INTO TABLE

CREATE OR REPLACE PROCEDURE Flight_Extract_ATBS
AS
    RowCt NUMBER(10);
    temp_sql VARCHAR(255) := 'TRUNCATE TABLE Flight_Stage_ATBS DROP STORAGE';
BEGIN
    EXECUTE IMMEDIATE temp_sql;
    
    INSERT INTO Flight_Stage_ATBS 
    SELECT f.Flight_Number,f.Departing_Airport_Code,f.Departing_Airport_Name,f.Ariving_Airport_Code,f.Ariving_Airport_Name,f.Departure_Gate,f.Arival_Gate,a.Airplane_Number,f.Fuel_Cost,f.Food_Cost,f.Departure_Date,f.Arival_Date
    FROM Flights_ATBS f
	LEFT JOIN Airplane_ATBS a
		ON f.Airplane_Number=a.Airplane_Number;
	 
--EXCEPTION TO CHECK ABOVE DATA INSERTION
    RowCt := SQL%ROWCOUNT;
    IF sql%notfound THEN
       dbms_output.put_line('No DATA FOUND!');
    ELSIF sql%found THEN
       dbms_output.put_line(TO_CHAR(RowCt) ||' Data Loaded');
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
       dbms_output.put_line(SQLERRM);
       dbms_output.put_line(temp_sql);
END;


-- DISPLAY THE PRINT LINE IN THE OUTPUT
SET SERVEROUT ON;
TRUNCATE TABLE Flight_Stage_ATBS;

-- INSERT DATA INTO ABOVE CREATED TABLE VIA PROCEDURE 'Flight_Extract_ATBS'
EXECUTE Flight_Extract_ATBS;
SELECT * FROM Flight_Stage_ATBS;





-- Stage Table For Booking
CREATE TABLE Booking_Stage_ATBS (
BookingNumber NUMBER(10) NOT NULL,
CustomerName nvarchar2(100)  NULL,
SeatNumber NUMBER(10) NOT NULL,
TicketPrice NUMBER(18, 2) NULL,									
SeatClass nvarchar2(50) NOT NULL,
TicketDate DATE  NULL,
BookingStatus nvarchar2(100)  NULL
);

-- PROCEDURE TO INSERT DATA INTO TABLE

CREATE OR REPLACE PROCEDURE Booking_Extract_ATBS
AS
    RowCt NUMBER(10);
    temp_sql VARCHAR(255) := 'TRUNCATE TABLE Booking_Stage_ATBS DROP STORAGE';
BEGIN
    EXECUTE IMMEDIATE temp_sql;
    
    INSERT INTO Booking_Stage_ATBS 
    SELECT cb.Booking_ID,cus.Customer_Name,cb.Seat_Number,t.Ticket_Price,cb.Seat_Class,t.Ticket_Date,t.Ticket_Status
    FROM CustomerBooking_ATBS cb
	LEFT JOIN Tickets_ATBS t
		ON cb.Ticket_Number=t.Ticket_Number
	LEFT JOIN Customer_ATBS cus
		ON cus.Customer_ID=t.Customer_ID;
	 
--EXCEPTION TO CHECK ABOVE DATA INSERTION
    RowCt := SQL%ROWCOUNT;
    IF sql%notfound THEN
       dbms_output.put_line('Record not found');
    ELSIF sql%found THEN
       dbms_output.put_line(TO_CHAR(RowCt) ||' Data Loaded');
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
       dbms_output.put_line(SQLERRM);
       dbms_output.put_line(temp_sql);
END;


-- DISPLAY THE PRINT LINE IN THE OUTPUT
SET SERVEROUT ON;
TRUNCATE TABLE Booking_Stage_ATBS;

-- INSERT DATA INTO ABOVE CREATED TABLE VIA PROCEDURE 'Flight_Extract_ATBS'
EXECUTE Booking_Extract_ATBS;
SELECT * FROM Booking_Stage_ATBS;





-- Load Preloaded Table


-- Preload Table Of Customer


CREATE TABLE Customer_Preload_ATBS (
CustomerKey NUMBER(10),
CustomerName NVARCHAR2(100) NULL,
CityName NVARCHAR2(500) NULL,
ProvinceName NVARCHAR2(100) NULL,
EmailAddress NVARCHAR2(100) NULL,
PhoneNumber NVARCHAR2(100) NULL,
StartDate DATE NOT NULL,
EndDate DATE NULL,
CONSTRAINT DimCustomers_PK PRIMARY KEY ( CustomerKey )
);

-- Create Sequence TO Identify
CREATE SEQUENCE CustomerKey START WITH 1 CACHE 10;
-- Create Procedure To Transform
CREATE OR REPLACE PROCEDURE Customer_Transform_ATBS
AS
    RowCt NUMBER(10);
    temp_sql VARCHAR(255) := 'TRUNCATE TABLE Customer_Preload_ATBS DROP STORAGE';
    temp_StartDate DATE := SYSDATE; 
    temp_EndDate DATE := ((SYSDATE) - 1);
BEGIN
    EXECUTE IMMEDIATE temp_sql;

-- Loading updated records 
    INSERT INTO Customer_Preload_ATBS 
        SELECT CustomerKey.NEXTVAL AS CustomerKey,
            stg.CustomerName,
            stg.CustomerCity,
            stg.CustomerState,
            stg.CustomerPhone,
            stg.CustomerEmail,
            StartDate,
            NULL
        FROM Customer_Stage_ATBS stg
        JOIN Dim_Customer_ATBS cu
            ON stg.CustomerName = cu.CustomerName AND cu.EndDate IS NULL
        WHERE stg.CustomerName <> cu.CustomerName
            OR stg.CustomerCity <> cu.CityName
            OR stg.CustomerState <> cu.ProvinceName
            OR stg.CustomerPhone <> cu.PhoneNumber
            OR stg.CustomerEmail <> cu.PhoneNumber;
            
    RowCt := SQL%ROWCOUNT;
   
-- Loading existing records
    INSERT INTO Customer_Preload_ATBS 
        SELECT cu.CustomerKey,
            cu.CustomerName,
            cu.CityName,
            cu.ProvinceName,
            cu.EmailAddress,
            cu.PhoneNumber,
            cu.StartDate,
            (CASE WHEN pl.CustomerName IS NULL THEN NULL
                ELSE cu.EndDate
            END) AS EndDate
        FROM Dim_Customer_ATBS cu
        LEFT JOIN Customer_Preload_ATBS pl 
            ON pl.CustomerName = cu.CustomerName
            AND cu.EndDate IS NULL;
            
    RowCt := RowCt+SQL%ROWCOUNT;


-- Loading newly created records
    INSERT INTO Customer_Preload_ATBS 
        SELECT CustomerKey.NEXTVAL AS CustomerKey, 
            stg.CustomerName,
            stg.CustomerCity,
            stg.CustomerState,
            stg.CustomerPhone,
            stg.CustomerEmail,
            (temp_StartDate),
            NULL
        FROM Customer_Stage_ATBS stg
        WHERE NOT EXISTS ( SELECT 1 FROM Dim_Customer_ATBS cu WHERE stg.CustomerName = cu.CustomerName );
        
    RowCt := RowCt+SQL%ROWCOUNT;

-- Loading expire missing records
    INSERT INTO Customer_Preload_ATBS 
        SELECT cu.CustomerKey,
            cu.CustomerName,
            cu.CityName,
            cu.ProvinceName,
            cu.EmailAddress,
            cu.PhoneNumber,
            cu.StartDate,
            (temp_EndDate)
        FROM Dim_Customer_ATBS cu
        WHERE NOT EXISTS ( SELECT 1 FROM Customer_Stage_ATBS stg WHERE stg.CustomerName = cu.CustomerName )
            AND cu.EndDate IS NULL;
    
--EXCEPTION TO CHECK WHETHER THE DATA HAS BEEN INSERTED OR NOT
    RowCt := SQL%ROWCOUNT;
    IF sql%notfound THEN
       dbms_output.put_line('Data Not Found!');
    ELSIF sql%found THEN
       dbms_output.put_line(TO_CHAR(RowCt) ||' Data Loaded');
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
       dbms_output.put_line(SQLERRM);
       dbms_output.put_line(temp_sql);
END;


-- DISPLAY THE PRINT LINE IN THE OUTPUT
SET SERVEROUT ON;
TRUNCATE TABLE Customer_preload_ATBS;

-- INSERT DATA INTO ABOVE CREATED TABLE VIA PROCEDURE 'Customer_Transform_ATBS'
EXECUTE Customer_Transform_ATBS;
SELECT * FROM Customer_preload_ATBS;






-- Preload Table Of Airplane

CREATE TABLE Airplane_Preload_ATBS (
AirplaneKey NUMBER(10),
AirplaneType NVARCHAR2(100) NULL,
AirlineCode NUMBER(20) NULL,
FirstSeating NUMBER(20) NULL,
SecondSeating NUMBER(20) NULL,
ThirdSeating NUMBER(20) NULL,
ArrivalDate DATE,
StartDate DATE,
CONSTRAINT DimAirplanes_PK PRIMARY KEY ( AirplaneKey )
);
-- Creating Sequence to uniquely identification
CREATE SEQUENCE AirplaneKey START WITH 1 CACHE 10;

-- Creating procedure for Transforming
CREATE OR REPLACE PROCEDURE Airplane_Transform_ATBS
AS
    RowCt NUMBER(10);
    temp_sql VARCHAR(255) := 'TRUNCATE TABLE Airplane_Preload_ATBS DROP STORAGE';
    temp_StartDate DATE := SYSDATE; 
    temp_EndDate DATE := ((SYSDATE) - 1);
BEGIN
    EXECUTE IMMEDIATE temp_sql;

-- Loading updated records 
    INSERT INTO Airplane_Preload_ATBS 
        SELECT AirplaneKey.NEXTVAL AS AirplaneKey,--
            stg.AirplaneType,
            stg.AirlineCode,
            stg.FirstClassSeats,
            stg.BusinessClassSeats,
            stg.EconomyClassSeats,
            NULL,
            NULL
        FROM Airplane_Stage_ATBS stg
        JOIN Dim_Airplane_ATBS cu
            ON stg.AirplaneType = cu.AirplaneType AND cu.ArrivalDate IS NULL
        WHERE stg.AirlineCode <> cu.AirlineCode
            OR stg.FirstClassSeats <> cu.FirstSeating
            OR stg.BusinessClassSeats <> cu.SecondSeating
            OR stg.EconomyClassSeats <> cu.ThirdSeating;
            
    RowCt := SQL%ROWCOUNT;
   
-- Loading existing records
    INSERT INTO Airplane_Preload_ATBS 
        SELECT cu.AirplaneKey,
            cu.AirplaneType,
            cu.AirlineCode,
            cu.FirstSeating,
            cu.SecondSeating,
            cu.ThirdSeating,
            NULL,
            (CASE WHEN pl.AirplaneType IS NULL THEN NULL
                ELSE cu.ArrivalDate
            END) AS ArrivalDate
        FROM Dim_Airplane_ATBS cu
        LEFT JOIN Airplane_Preload_ATBS pl 
            ON pl.AirplaneType = cu.AirplaneType
            AND cu.ArrivalDate IS NULL;
            
    RowCt := RowCt+SQL%ROWCOUNT;


-- Loading newly created records
    INSERT INTO Airplane_Preload_ATBS 
        SELECT AirplaneKey.NEXTVAL AS AirplaneKey, 
            stg.AirplaneType,
            stg.AirlineCode,
            stg.FirstClassSeats,
            stg.BusinessClassSeats,
            stg.EconomyClassSeats,
            (temp_StartDate),
            NULL
        FROM Airplane_Stage_ATBS stg
        WHERE NOT EXISTS ( SELECT 1 FROM Dim_Airplane_ATBS cu WHERE stg.AirplaneType = cu.AirplaneType );
        
    RowCt := RowCt+SQL%ROWCOUNT;

-- Loading expire missing records
    INSERT INTO Airplane_Preload_ATBS 
        SELECT cu.AirplaneKey,
            cu.AirplaneType,
            cu.AirlineCode,
            cu.FirstSeating,
            cu.SecondSeating,
            cu.ThirdSeating,
            cu.DepartureDate,
            (temp_EndDate)
        FROM Dim_Airplane_ATBS cu
        WHERE NOT EXISTS ( SELECT 1 FROM Airplane_Stage_ATBS stg WHERE stg.AirplaneType = cu.AirplaneType )
            AND cu.ArrivalDate IS NULL;
    
--EXCEPTION TO CHECK WHETHER THE DATA HAS BEEN INSERTED OR NOT
    RowCt := SQL%ROWCOUNT;
    IF sql%notfound THEN
       dbms_output.put_line('Record not found');
    ELSIF sql%found THEN
       dbms_output.put_line(TO_CHAR(RowCt) ||' Data Loaded');
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
       dbms_output.put_line(SQLERRM);
       dbms_output.put_line(temp_sql);
END;

-- TO DISPLAY THE ABOVE PRINT LINE IN THE OUTPUT SCREEN---
SET SERVEROUT ON;
TRUNCATE TABLE Airplane_preload_ATBS;

-- TO ENTER THE DATA INTO THE ABOVE CREATED TABLE 'AIRPLANE_TRANSFORM' VIA PROCEDURE
EXECUTE Airplane_Transform_ATBS;
SELECT * FROM Airplane_preload_ATBS;






-- Preload Table Of Airline

CREATE TABLE Airline_Preload_ATBS (
AirlineKey NUMBER(10),
AirlineCode NUMBER(10),
AirlineName NVARCHAR2(500) NULL,
StartDate DATE,
EndDate DATE,
CONSTRAINT DimAirlines_PK PRIMARY KEY (AirlineKey )
);

-- Creating Sequence to uniquely identification
CREATE SEQUENCE AirlineKey START WITH 1 CACHE 10;

-- Creating procedure for Transforming
CREATE OR REPLACE PROCEDURE Airline_Transform_ATBS
AS
    RowCt NUMBER(10);
    temp_sql VARCHAR(255) := 'TRUNCATE TABLE Airline_Preload_ATBS DROP STORAGE';
    temp_StartDate DATE := SYSDATE; 
    temp_EndDate DATE := ((SYSDATE) - 1);
BEGIN
    EXECUTE IMMEDIATE temp_sql;

-- Loading updated records 
    INSERT INTO Airline_Preload_ATBS 
        SELECT AirlineKey.NEXTVAL AS AirlineKey,--
            stg.AirlineCode,
            stg.AirlineName,
            StartDate,
			NULL
        FROM Airline_Stage_ATBS stg
        JOIN Dim_Airline_ATBS cu
            ON stg.AirlineName = cu.AirlineName
        WHERE stg.AirlineCode <> cu.AirlineCode;
            
    RowCt := SQL%ROWCOUNT;
   
-- Loading existing records
    INSERT INTO Airline_Preload_ATBS 
        SELECT cu.AirlineKey,
            cu.AirlineCode,
            cu.AirlineName,
            Null,
            (CASE WHEN pl.AirlineCode IS NULL THEN NULL
                ELSE cu.EndDate
            END) AS EndDate
        FROM Dim_Airline_ATBS cu
        LEFT JOIN Airline_Preload_ATBS pl 
            ON pl.AirlineCode = cu.AirlineCode;
            
    RowCt := RowCt+SQL%ROWCOUNT;

-- Loading newly created records
    INSERT INTO Airline_Preload_ATBS 
        SELECT AirlineKey.NEXTVAL AS AirlineKey, 
            stg.AirlineCode,
            stg.AirlineName,
            (temp_StartDate),
            NULL
        FROM Airline_Stage_ATBS stg
        WHERE NOT EXISTS ( SELECT 1 FROM Dim_Airline_ATBS cu WHERE stg.AirlineCode = cu.AirlineCode );
        
    RowCt := RowCt+SQL%ROWCOUNT;

-- Loading expire missing records
    INSERT INTO Airline_Preload_ATBS 
        SELECT cu.AirlineKey,
            cu.AirlineCode,
            cu.AirlineName,
            cu.StartDate,
            (temp_EndDate)
        FROM Dim_Airline_ATBS cu
        WHERE NOT EXISTS ( SELECT 1 FROM Airline_Stage_ATBS stg WHERE stg.AirlineCode = cu.AirlineCode )
            AND cu.EndDate IS NULL;
    
--EXCEPTION TO CHECK WHETHER THE DATA HAS BEEN INSERTED OR NOT
    RowCt := SQL%ROWCOUNT;
    IF sql%notfound THEN
       dbms_output.put_line('Record not found');
    ELSIF sql%found THEN
       dbms_output.put_line(TO_CHAR(RowCt) ||' Data Loaded');
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
       dbms_output.put_line(SQLERRM);
       dbms_output.put_line(temp_sql);
END;

-- TO DISPLAY THE ABOVE PRINT LINE IN THE OUTPUT SCREEN---
SET SERVEROUT ON;
TRUNCATE TABLE Airline_Preload_ATBS;

-- TO ENTER THE DATA INTO THE ABOVE CREATED TABLE 'AIRPLINE_TRANSFORM' VIA PROCEDURE
EXECUTE Airline_Transform_ATBS;
SELECT * FROM Airline_Preload_ATBS;






-- Preload Table Of Flight

CREATE TABLE Flight_Preload_ATBS (
FlightKey NUMBER(10) NOT NULL,
DepartAirportName nvarchar2(500) NOT NULL,
ArivalAirportName nvarchar2(500) NOT NULL,
DepartureGate NUMBER(10) NOT NULL,
AirplaneID NUMBER(10)NOT NULL,
FuelCost NUMBER(18, 2) NOT NULL,
FoodCost NUMBER(18, 2) NOT NULL,
DepartureDate DATE ,
ArivalDate DATE ,
CONSTRAINT DimFlight_PK PRIMARY KEY (FlightKey)
);

-- Creating Sequence to uniquely identification
CREATE SEQUENCE FlightKey START WITH 1 CACHE 10;
-- Creating procedure for Transforming
CREATE OR REPLACE PROCEDURE Flight_Transform_ATBS
AS
    RowCt NUMBER(10);
    temp_sql VARCHAR(255) := 'TRUNCATE TABLE Flight_Preload_ATBS DROP STORAGE';
    temp_StartDate DATE := SYSDATE; 
    temp_EndDate DATE := ((SYSDATE) - 1);
BEGIN
    EXECUTE IMMEDIATE temp_sql;

-- Loading updated records 
    INSERT INTO Flight_Preload_ATBS 
        SELECT FlightKey.NEXTVAL AS FlightKey,--
            stg.DepartAirportName,
            stg.ArivalAirportName,
			stg.DepartureGate,
			stg.AirplaneNumber,
			stg.FuelCost,
			stg.FoodCost,
            NULL,
            NULL
        FROM Flight_Stage_ATBS stg
        JOIN Dim_Flights_ATBS cu
            ON stg.DepartAirportName = cu.DepartingAirportName  AND cu.ArivalDate IS NULL
        WHERE stg.ArivalAirportName <> cu.ArivingAirportName
		   OR stg.DepartureGate <> cu.DepartureGate
		   OR stg.AirplaneNumber <> cu.AirplaneNumber
           OR stg.FuelCost <> cu.FuelCost
           OR stg.FoodCost <> cu.FoodCost;
            
    RowCt := SQL%ROWCOUNT;
   
-- Loading existing records
    INSERT INTO Flight_Preload_ATBS 
        SELECT cu.FlightKey,
            cu.DepartingAirportName,
            cu.ArivingAirportName,
			cu.DepartureGate,
			cu.AirplaneNumber,
			cu.FuelCost,
			cu.FoodCost,
            NULL,
            (CASE WHEN pl.AirplaneID IS NULL THEN NULL
                ELSE cu.ArivalDate
            END) AS ArivalDate
        FROM Dim_Flights_ATBS cu
        LEFT JOIN Flight_Preload_ATBS pl 
            ON pl.AirplaneID = cu.AirplaneNumber;
            
            RowCt := RowCt+SQL%ROWCOUNT;

-- Loading newly created records
    INSERT INTO Flight_Preload_ATBS 
        SELECT FlightKey.NEXTVAL AS FlightKey, 
            stg.DepartAirportName,
            stg.ArivalAirportName,
			stg.DepartureGate,
			stg.AirplaneNumber,
			stg.FuelCost,
			stg.FoodCost,
            NULL,
            (temp_StartDate)
            FROM Flight_Stage_ATBS stg
        WHERE NOT EXISTS ( SELECT 1 FROM Dim_Flights_ATBS cu WHERE stg.AirplaneNumber = cu.AirplaneNumber );
        
    RowCt := RowCt+SQL%ROWCOUNT;

-- Loading expire missing records
    INSERT INTO Flight_Preload_ATBS 
        SELECT cu.FlightKey,
            cu.DepartingAirportName,
            cu.ArivingAirportName,
            cu.DepartureGate,
            cu.AirplaneNumber,
			cu.FuelCost,
			cu.FoodCost,
            NULL,
            (temp_EndDate)
        FROM Dim_Flights_ATBS cu
        WHERE NOT EXISTS ( SELECT 1 FROM Flight_Stage_ATBS stg WHERE stg.AirplaneNumber = cu.AirplaneNumber )
            AND cu.ArivalDate IS NULL;
    
--EXCEPTION TO CHECK WHETHER THE DATA HAS BEEN INSERTED OR NOT
    RowCt := SQL%ROWCOUNT;
    IF sql%notfound THEN
       dbms_output.put_line('Record not found');
    ELSIF sql%found THEN
       dbms_output.put_line(TO_CHAR(RowCt) ||' Data Loaded !');
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
       dbms_output.put_line(SQLERRM);
       dbms_output.put_line(temp_sql);
END;

-- TO DISPLAY THE ABOVE PRINT LINE IN THE OUTPUT SCREEN---
SET SERVEROUT ON;
TRUNCATE TABLE Flight_Preload_ATBS;

-- TO ENTER THE DATA INTO THE ABOVE CREATED TABLE 'FLIGHT_TRANSFORM' VIA PROCEDURE
EXECUTE Flight_Transform_ATBS;
SELECT * FROM Flight_Preload_ATBS;












-- Anjan Shah - 8817999
-- Prabhjot Singh - 8752445
-- Savita Sharma - 8735811
-- Kamini Banwala - 8818829