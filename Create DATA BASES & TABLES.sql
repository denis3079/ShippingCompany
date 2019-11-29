CREATE DATABASE ShippingCompany;

CREATE TABLE E_1_Captain
(
	Captain_personal_number int NOT NULL , -- оепянмюкэмши мнлеп йюохрюмю
	Voyage_number VARCHAR(15) REFERENCES E_4_Voyage (Voyage_number) ON DELETE CASCADE, -- бмеьмхи йкчв - мнлеп пеияю
	LastName varchar(100) NOT NULL , -- тюлхкхъ
	FirstName varchar(100) NOT NULL , -- хлъ
	PatronimicName varchar(100) NULL , -- нрвеярбн
	PassportSerial char(4) NOT NULL , -- яепхъ оюяонпрю 
	PassportNumber char(6) NOT NULL , -- мнлеп оюяонпрю
	LicenseNumber varchar(10) NOT NULL , -- мнлеп кхжемгхх мю опюбн сопюбкемхъ ясдюлх
	Experience int NOT NULL , -- рпсднбни ярюф 
    PRIMARY KEY (Captain_personal_number) -- оепбхвмши йкчв - оепянмюкэмши мнлеп йюохрюмю
)
go

CREATE TABLE E_2_Ship
(
	NameShip varchar(35) NOT NULL , -- мюхлемнбюмхе йнпюакъ
	TonnageShip int REFERENCES E_7_Ship_declaration (TonnageShip) ON DELETE NO ACTION, -- бмеьмхи йкчв - цпсгнондзелмнярэ ясдмю
	SupportShip VARCHAR(35) REFERENCES E_2_Ship (NameShip) ON DELETE NO ACTION, -- бмеьмхи йкчв - янопнбнфдючыхи йнпюакэ
	Captain_personal_number int REFERENCES E_1_Captain (Captain_personal_number) ON DELETE CASCADE, -- бмеьмхи йкчв - оепянмюкэмши мнлеп йюохрюмю
	ABC_analyze VARCHAR(10) REFERENCES E_11_Rank (ABC_analyze) ON DELETE CASCADE, -- бмеьмхи йкчв - A, B, C юмюкхг
	Passenger_ship_capacity int NULL , -- оюяяюфхпнблеярхлнярэ
	ShipStatus varchar(35) NOT NULL , -- ярюрся ясдмю
	Year_of_issue int NOT NULL , -- цнд бшосяйю ясдмю
	Annual_service_payment decimal(12,2)  NOT NULL , -- ярнхлнярэ цнднбнцн наяксфхбюмхъ
	Ship_decommissioning_act int NULL , -- юйр яохяюмхъ ясдмю
	PRIMARY KEY (NameShip) -- оепбхвмши йкчв - мюхлемнбюмхе ясдмю
)
go
    


CREATE TABLE E_3_Port
(
	Port_name varchar(35) NOT NULL , -- мюхлемнбюмхе онпрю
	Port_ID int REFERENCES E_13_Port_catalog (Port_ID) ON DELETE CASCADE, -- бмеьмхи йкчв - хдемрхтхйюрнп онпрю
	Parent_port VARCHAR(35) REFERENCES E_3_Port (Port_name) ON DELETE NO ACTION, -- бмеьмхи йкчв - опнлефсрнвмши онпр
	Country varchar(35) NOT NULL , -- ярпюмю
	City varchar(35) NOT NULL , -- цнпнд
	Coordinates varchar(35) NOT NULL , -- йннпдхмюрш
	Cost_staying_port decimal(12,2) NOT NULL , -- ярнхлнярэ мюунфдемхъ б онпрс
	Ship_unloading_cost decimal(12,2) NULL , -- ярнхлнярэ пюгцпсгйх
	PRIMARY KEY (Port_name) -- оепбхвмши йкчв - мюхлемнбюмхе онпрю
)
go

CREATE TABLE E_4_Voyage
(
	Voyage_number varchar(15)  NOT NULL , -- мнлеп пеияю
	Port_departure VARCHAR(35) REFERENCES E_3_Port (Port_name) ON UPDATE NO ACTION, -- бмеьмхи йкчв - онпр нропюбкемхъ
	Port_arrival VARCHAR(35) REFERENCES E_3_Port (Port_name) ON UPDATE NO ACTION, -- бмеьмхи йкчв - онпр опхашрхъ
	Flotilla varchar(35) NULL , -- ткнрхкхъ йнпюакеи
	MilitaryEscort varchar(35) NULL , -- бнеммне янопнбнфдемхе
	DepartureDate datetime NOT NULL , -- дюрю нропюбкемхъ
	ArrivalDate datetime NOT NULL , -- дюрю опхашрхъ
	Distance int  NOT NULL , -- пюяярнъмхе
	PassengersDeparted int NULL , -- нропюбкъчыхеяъ оюяяюфхпш
	PassengersArrived int NULL , -- опхашбьхе оюяяюфхпш
	UnloadedShip int NULL , -- пюгцпсфемн рнмм
	LoadedShip int NULL , -- гюцпсфемн рнмм
	PRIMARY KEY (Voyage_number) -- оепбхвмши йкчв - мнлеп пеияю
)
go

CREATE TABLE E_5_Client
(
	Customers_internal_account varchar(50) NOT NULL , -- оепянмюкэмши мнлеп йкхемрю
	LastName varchar(100) NOT NULL , -- тюлхкхъ
	FirstName varchar(100) NOT NULL , -- хлъ
	PatronimicName varchar(100) NULL , -- нрвеярбн
	PassportSerial varchar(4) NOT NULL , -- яепхъ оюяонпрю
	PassportNumber varchar(6) NOT NULL , -- мнлеп оюяонпрю
	Foto image NULL , -- тнрн\
	PRIMARY KEY (Customers_internal_account) -- оепбхвмши йкчв - оепянмюкэмши мнлеп йкхемрю
)
go

CREATE TABLE E_6_Ticket
(
	Number_of_ticket varchar(50) NOT NULL , -- мнлеп ахкерю
    Voyage_number VARCHAR(15) REFERENCES E_4_Voyage (Voyage_number) ON DELETE CASCADE, -- бмеьмхи йкчв - мнлеп пеияю 
	Customers_internal_account int REFERENCES E_5_Client (Customers_internal_account) ON DELETE CASCADE, -- бмеьмхи йкчв - оепянмюкэмши мнлеп йкхемрю
	NameShip VARCHAR(35) REFERENCES E_2_Ship (NameShip) ON UPDATE NO ACTION, -- бмеьмхи йкчв - мюхлемнбюмхе йюпюакъ
	Class VARCHAR(20) REFERENCES E_8_Cabin_class (Class) ON DELETE CASCADE, -- бмеьмхи йкчв - йкюяя йючрш
	Port_departure VARCHAR(35) REFERENCES E_3_Port (Port_name) ON UPDATE NO ACTION, -- бмеьмхи йкчв - онпр нропюбкемхъ
	Port_arrival VARCHAR(35) REFERENCES E_3_Port (Port_name) ON UPDATE NO ACTION, -- бмеьмхи йкчв - онпр опхашрхъ
	TicketPrice decimal(12,2)  NOT NULL , -- жемю ахкерю
	PRIMARY KEY (Number_of_ticket) -- оепбхвмше йкчвх - мнлеп ахкерю
)
go

CREATE TABLE E_7_Ship_declaration
(
	TonnageShip int NOT NULL , -- цпсгнондзелмнярэ ясдмю
	Declaration_number varchar(25) NOT NULL , -- мнлеп дейкюпюжхх
	Customers_internal_account int REFERENCES E_5_Client (Customers_internal_account) ON DELETE CASCADE , -- бмеьмхи йкчв - оепянмюкэмши мнлеп йкхемрю
	Voyage_number VARCHAR(15) REFERENCES E_4_Voyage (Voyage_number) ON DELETE CASCADE , -- бмеьмхи йкчв - мнлеп пеияю
	NameCargo VARCHAR(35) REFERENCES E_9_Type_cargo (NameCargo) ON DELETE CASCADE , -- бмеьмхи йкчв - мюхлемнбюмхе цпсгю
	Port_departure VARCHAR(35) REFERENCES E_3_Port (Port_name) ON UPDATE NO ACTION , -- бмеьмхи йкчв - онпр нропюбкемхъ
	Port_arrival VARCHAR(35) REFERENCES E_3_Port (Port_name) ON UPDATE NO ACTION , -- бмеьмхи йкчв - онпр опхашрхъ
	CostCargoTransportation decimal(12,2)  NOT NULL ,
	PRIMARY KEY (TonnageShip) -- оепбхвмши йкчв - цпсгнондзелмнярэ ясдмю
)
go

CREATE TABLE E_8_Cabin_class
(
	Class varchar(20) NOT NULL , -- йкюяя йючр
	NumberSeatsCabin int  NOT NULL , -- мнлеп леярю б йючре
	CabinCost decimal(12,2)  NOT NULL , -- ярнхлнярэ леярю б йючре
	PRIMARY KEY (Class) -- оепбхвмши йкчв - йкюяя йючр
)
go

CREATE TABLE E_9_Type_cargo
(
	NameCargo varchar(35) NOT NULL , -- мюхлемнбюмхе цпсгю
	CatalogGoods varchar(35) NOT NULL , -- оепевемэ рпюмяонпрхпнбюммнцн цпсгю / рнбюпнб
	TransportCost1Ton decimal(12,2)  NOT NULL , -- ярнхлнярэ рпюмяонпрхпнбйх 1 рнммш цпсгю
	PRIMARY KEY (NameCargo) -- оепбхвмши йкчв - мюхлемнбюмхе цпсгю
)
go

CREATE TABLE E_10_Produkt
(
	NameProduct varchar(35) NOT NULL , -- мюхлемнбюмхе рнбюпнб
	NameCargo VARCHAR(35) REFERENCES E_9_Type_cargo (NameCargo) ON DELETE CASCADE, -- бмеьмхи йкчв - мюхлемнбюмхе цпсгю
	PRIMARY KEY (NameProduct) -- оепбхвмши йкчв - мюхлемнбюмхе рнбюпнб
)
go                                              

CREATE TABLE E_11_Rank
(
	ABC_analyze varchar(10) NOT NULL , -- ю, б, я юмюкхг
    PRIMARY KEY (ABC_analyze) -- оепбхвмши йкчв - ю, б, я юмюкхг
)
go

CREATE TABLE E_12_Cabin_ship
(
	Class VARCHAR(20) REFERENCES E_8_Cabin_class (Class) ON DELETE CASCADE, -- бмеьмхи йкчв - йкюяя йючр
	NameShip VARCHAR(35) REFERENCES E_2_Ship (NameShip) ON DELETE CASCADE, -- бмеьмхи йкчв - мюхлемнбюмхе йюпюакъ
	NumberCabinShip int  NOT NULL , -- мнлеп йючрш
	TotalNumberCabins int  NOT NULL , -- наыее вхякн йючр
	PRIMARY KEY (Class, NameShip) -- оепбхвмше йкчвх - йкюяя йючр, мюхлемнбюмхе йюпюакъ 
)
go

CREATE TABLE E_13_Port_catalog
(
	Port_ID int NOT NULL , -- хдемрхтхйюрнп онпрю
	NamePort varchar(35) NOT NULL, -- мюхлемнбюмхе онпрю
	PRIMARY KEY (Port_ID) -- оепбхвмши йкчв - хдемрхтхйюрнп онпрю
)
go
