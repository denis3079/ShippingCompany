CREATE DATABASE ShippingCompany;

CREATE TABLE E_1_Captain
(
	Captain_personal_number int NOT NULL ,
	Voyage_number VARCHAR(15) REFERENCES E_4_Voyage (Voyage_number) ON DELETE CASCADE,
	LastName varchar(100) NOT NULL ,
	FirstName varchar(100) NOT NULL , 
	PatronimicName varchar(100) NULL ,
	PassportSerial char(4) NOT NULL ,
	PassportNumber char(6) NOT NULL ,
	LicenseNumber varchar(10) NOT NULL ,
	Experience int NOT NULL ,
    PRIMARY KEY (Captain_personal_number)
)
go

CREATE TABLE E_2_Ship
(
	NameShip varchar(35) NOT NULL,
	TonnageShip int REFERENCES E_7_Ship_declaration (TonnageShip) ON DELETE NO ACTION,
	SupportShip VARCHAR(35) REFERENCES E_2_Ship (NameShip) ON DELETE NO ACTION,
	Captain_personal_number int REFERENCES E_1_Captain (Captain_personal_number) ON DELETE CASCADE,
	ABC_analyze CHAR(10) REFERENCES E_11_Rank (ABC_analyze) ON DELETE CASCADE,
	Passenger_ship_capacity int NULL ,
	ShipStatus varchar(35) NOT NULL ,
	Year_of_issue int NOT NULL ,
	Annual_service_payment decimal(12,2)  NOT NULL ,
	Ship_decommissioning_act int NULL ,
	PRIMARY KEY (NameShip)
)
go
    


CREATE TABLE E_3_Port
(
	Port_name varchar(35) NOT NULL ,
	Port_ID int REFERENCES E_13_Port_catalog (Port_ID) ON DELETE CASCADE,
	Parent_port VARCHAR(35) REFERENCES E_3_Port (Port_name) ON DELETE NO ACTION,
	Country varchar(35) NOT NULL ,
	City varchar(35) NOT NULL ,
	Coordinates varchar(35) NOT NULL ,
	Cost_staying_port decimal(12,2) NOT NULL ,
	Ship_unloading_cost decimal(12,2) NULL ,
	PRIMARY KEY (Port_name)
)
go

CREATE TABLE E_4_Voyage
(
	Voyage_number varchar(15)  NOT NULL ,
	Port_departure VARCHAR(35) REFERENCES E_3_Port (Port_name) ON UPDATE NO ACTION,
	Port_arrival VARCHAR(35) REFERENCES E_3_Port (Port_name) ON UPDATE NO ACTION,
	Flotilla varchar(35) NULL ,
	MilitaryEscort varchar(35) NULL ,
	DepartureDate datetime NOT NULL ,
	ArrivalDate datetime NOT NULL ,
	Distance int  NOT NULL ,
	PassengersDeparted int NULL ,
	PassengersArrived int NULL ,
	UnloadedShip int NULL ,
	LoadedShip int NULL ,
	PRIMARY KEY (Voyage_number)
)
go

CREATE TABLE E_5_Client
(
	Customers_internal_account varchar(50) NOT NULL ,
	LastName varchar(100) NOT NULL ,
	FirstName varchar(100) NOT NULL ,
	PatronimicName varchar(100) NULL ,
	PassportSerial varchar(4) NOT NULL ,
	PassportNumber varchar(6) NOT NULL ,
	Foto image NULL ,
	PRIMARY KEY (Customers_internal_account)
)
go

CREATE TABLE E_6_Ticket
(
	Number_of_ticket varchar(50) NOT NULL ,
        Voyage_number VARCHAR(15) REFERENCES E_4_Voyage (Voyage_number) ON DELETE CASCADE,
	Customers_internal_account int REFERENCES E_5_Client (Customers_internal_account) ON DELETE CASCADE,
	NameShip VARCHAR(35) REFERENCES E_2_Ship (NameShip) ON UPDATE NO ACTION,
	Class VARCHAR(20) REFERENCES E_8_Cabin_class (Class) ON DELETE CASCADE,
	Port_departure VARCHAR(35) REFERENCES E_3_Port (Port_name) ON UPDATE NO ACTION,
	Port_arrival VARCHAR(35) REFERENCES E_3_Port (Port_name) ON UPDATE NO ACTION,
	TicketPrice decimal(12,2)  NOT NULL ,
	PRIMARY KEY (Number_of_ticket)
)
go

CREATE TABLE E_7_Ship_declaration
(
	TonnageShip int NOT NULL ,
	Declaration_number varchar(25) NOT NULL ,
	Customers_internal_account int REFERENCES E_5_Client (Customers_internal_account) ON DELETE CASCADE ,
	Voyage_number VARCHAR(15) REFERENCES E_4_Voyage (Voyage_number) ON DELETE CASCADE ,
	NameCargo VARCHAR(35) REFERENCES E_9_Type_cargo (NameCargo) ON DELETE CASCADE ,
	Port_departure VARCHAR(35) REFERENCES E_3_Port (Port_name) ON UPDATE NO ACTION ,
	Port_arrival VARCHAR(35) REFERENCES E_3_Port (Port_name) ON UPDATE NO ACTION ,
	CostCargoTransportation decimal(12,2)  NOT NULL ,
	PRIMARY KEY (TonnageShip)
)
go

CREATE TABLE E_8_Cabin_class
(
	Class varchar(20) NOT NULL ,
	NumberSeatsCabin int  NOT NULL ,
	CabinCost decimal(12,2)  NOT NULL ,
	PRIMARY KEY (Class)
)
go

CREATE TABLE E_9_Type_cargo
(
	NameCargo varchar(35) NOT NULL ,
	CatalogGoods varchar(35) NOT NULL ,
	TransportCost1Ton decimal(12,2)  NOT NULL ,
	PRIMARY KEY (NameCargo)
)
go

CREATE TABLE E_10_Produkt
(
	NameProduct varchar(35) NOT NULL ,
	NameCargo VARCHAR(35) REFERENCES E_9_Type_cargo (NameCargo) ON DELETE CASCADE,
	PRIMARY KEY (NameProduct)
)
go                                              

CREATE TABLE E_11_Rank
(
	ABC_analyze varchar(10) NOT NULL ,
    PRIMARY KEY (ABC_analyze)
)
go

CREATE TABLE E_12_Cabin_ship
(
	Class VARCHAR(20) REFERENCES E_8_Cabin_class (Class) ON DELETE CASCADE,
	NameShip VARCHAR(35) REFERENCES E_2_Ship (NameShip) ON DELETE CASCADE,
	NumberCabinShip int  NOT NULL ,
	TotalNumberCabins int  NOT NULL ,
	PRIMARY KEY (Class, NameShip)
)
go

CREATE TABLE E_13_Port_catalog
(
	Port_ID int NOT NULL ,
	NamePort varchar(35) NOT NULL,
	PRIMARY KEY (Port_ID)
)
go
