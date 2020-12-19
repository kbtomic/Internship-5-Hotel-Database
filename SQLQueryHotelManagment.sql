create database HotelManagment

use HotelManagment

create table Hotels(
	Id int IDENTITY(1,1) PRIMARY KEY,
	HotelName nvarchar(50) NOT NULL,
	City nvarchar(50) NOT NULL,
	Adress nvarchar(50) NOT NULL,
	Stars int NOT NULL CHECK(Stars BETWEEN 1 AND 5)
)

create table Employees(
	Id int IDENTITY(1,1) PRIMARY KEY,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	Job nvarchar(50) NOT NULL CHECK(Job = 'recepcionist' OR Job = 'janitor' OR Job = 'room service' OR Job = 'kitchen stuff' OR Job = 'manager'),
	Salary int NOT NULL,
	HotelId int FOREIGN KEY REFERENCES Hotels(Id) NOT NULL
)

create table Rooms(
	Id int IDENTITY(1,1) PRIMARY KEY,
	Number int,
	Category nvarchar(50) NOT NULL CHECK(Category = 'single' OR Category = 'double' OR Category = 'triple' OR Category = 'apartment' OR Category = 'suite'),
	Capacity int NOT NULL,
	Balcony BIT,
	PricePerNight int NOT NULL,
	HotelId int FOREIGN KEY REFERENCES Hotels(Id) NOT NULL
)

create table Buyers(
	Id int IDENTITY(1,1) PRIMARY KEY,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	OIB nvarchar(30) NOT NULL,
	Email nvarchar(50) NOT NULL,
	PhoneNumber nvarchar(20) NOT NULL,
)

create table Reservations(
	Id int IDENTITY(1,1) PRIMARY KEY,
	DateOfReservation datetime2 NOT NULL,
	ArrivalDate DateTime2 NOT NULL,
	DepartureDate DateTime2 NOT NULL,
	Price int NOT NULL,
	TypeOfStay nvarchar(50) CHECK(TypeOfStay = 'nothing' OR TypeOfStay = 'pansion' OR TypeOfStay = 'half pansion') NOT NULL,
	BuyerId int FOREIGN KEY REFERENCES Buyers(Id) NOT NULL,
	RoomId int FOREIGN KEY REFERENCES Rooms(Id) NOT NULL
)

create table Stays(
	Id int PRIMARY KEY REFERENCES Reservations(Id) NOT NULL,
)

create table Visitors(
	Id int IDENTITY(1,1) PRIMARY KEY,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	Age int NOT NULL,
	OIB nvarchar(30) NOT NULL,
	PhoneNumber nvarchar(20) NOT NULL,
	Nationality nvarchar(50) NOT NULL,
	Pet BIT
)

create table VisitorStays(
	VisitorId int FOREIGN KEY REFERENCES Visitors(Id) NOT NULL,
	StayId int FOREIGN KEY REFERENCES Stays(Id) NOT NULL,
	CONSTRAINT VisitorStaysPrimaryKey PRIMARY KEY(VisitorId,StayId)
)

--
insert into Hotels(HotelName, City, Adress, Stars) VALUES
	('Lav', 'Podstrana', 'Grljevacka 2A', 4),
	('Zagreb', 'Split', 'Put Duilova 23', 2),
	('Delfin', 'Makarska', 'Vukovarska 2', 5),
	('Sirena', 'Vela Luka', 'Osjecka 3', 5),
	('Kralj', 'Umag', 'Domovinskog rata 22', 4)
--
insert into Employees(FirstName, LastName, Job, HotelId, Salary) VALUES
	('Ana', 'Anic', 'recepcionist',1, 5000),
	('Ana', 'Banic', 'janitor',1, 2000),
	('Anica', 'Bananic', 'room service',1, 4500),
	('Marko', 'Markic', 'recepcionist',1, 5100),
	('Marta', 'Parkic', 'room service',2, 5000),
	('Ante', 'Anic', 'room service',2, 5200),
	('Matko', 'Rudic', 'recepcionist',2, 5000),
	('Marina', 'Dude', 'manager',2, 10000),
	('Mihaela', 'Baric', 'kitchen stuff',3, 2000),
	('Mirna', 'Manic', 'room service',3, 1000),
	('Duje', 'Sokol', 'recepcionist',3, 1500),
	('Mate', 'Matic', 'recepcionist',4, 2000),
	('Petar', 'Peric', 'janitor',4, 3000),
	('Miljenko', 'Zderic', 'janitor',4, 2000),
	('Kresimir', 'Nonic', 'janitor',5, 3000),
	('Ankica', 'Anicic', 'manager',5, 20000)
--
insert into Rooms(Number, Category, Capacity, Balcony, PricePerNight, HotelId) VALUES
	(100, 'suite', 2, 1, 700, 1),
	(110, 'apartment', 2, 1, 500, 1),
	(220, 'single', 1, 0, 200, 1),
	(100, 'suite', 2, 1, 700, 1),
	(200, 'double', 2, 1, 400, 2),
	(300, 'triple', 3, 0, 2020, 2),
	(100, 'double', 2, 1, 700, 3),
	(110, 'triple', 2, 0, 1000, 3),
	(120, 'single', 1, 0, 200, 3),
	(100, 'suite', 2, 1, 7000, 4),
	(110, 'apartment', 2, 1, 550, 4),
	(100, 'single', 1, 0, 200, 5)
--
insert into Buyers(FirstName, LastName, OIB, Email, PhoneNumber) VALUES
	('Marija', 'Maric', '01234', 'marija.maric@gmail.com', '09987654321'),
	('Ante', 'Maretic', '01343', 'ante.maretic@gmail.com', '09987654322'),
	('Marija', 'Maric', '01234', 'marija.maric@gmail.com', '09987654321'),
	('Ivan', 'Maretic', '01311', 'ivan.maretic@gmail.com', '09987654312'),
	('Ana', 'Maricic', '01232', 'ana.maricic@gmail.com', '09987654222'),
	('Ankica', 'Baric', '01343', 'ankica.baric@gmail.com', '09987654111'),
	('Mato', 'Matic', '01114', 'mato.matic@gmail.com', '09587654223'),
	('Petar', 'Peric', '01343', 'petar.peric@gmail.com', '09287654131')
--
insert into Reservations(DateOfReservation, ArrivalDate, DepartureDate, Price, TypeOfStay, BuyerId, RoomId) VALUES
	('2020-12-12 12:30', '2020-12-17 21:30', '2020-12-25 21:00', 1500, 'pansion', 1, 1),
	('2020-12-10 12:30', '2020-12-11 12:30', '2020-12-12 12:30', 1500, 'pansion', 1, 1),
	('2000-12-10 11:30', '2000-12-13 11:30', '2020-12-14 12:30', 1000, 'pansion', 1, 1),
	('2019-12-12 21:00', '2019-12-13 21:00', '2019-12-14 08:00', 10000, 'pansion', 2, 2),
	('2004-10-12 08:00', '2004-10-13 08:00', '2004-10-14 21:00', 590, 'nothing', 3, 3),
	('2020-10-12 08:00', '2020-10-12 21:00', '2020-10-22 08:00', 500, 'half pansion', 4, 4),
	('2002-8-12 08:00','2020-11-12 20:00', '2020-11-15 08:00', 500, 'nothing', 6, 1)
--
insert into Stays(Id) VALUES
	(1),
	(2),
	(3),
	(6)
--
insert into Visitors(FirstName, LastName, Age, OIB, PhoneNumber, Nationality, Pet) VALUES
	('Marija', 'Maric', '22', '012', '09987654321', 'Croatian', 1),
	('Marko', 'Maretic', '30', '013', '09987654322', 'Croatian', 1),
	('Marija', 'Maric', '20', '014', '09987654321', 'Croatian', 0),
	('Ivan', 'Maretic', '33', '015', '09987654312', 'Croatian', 1),
	('Milka', 'Maricic', '33', '016', '09987654222', 'Croatian', 1),
	('Ankica', 'Baric', '44', '017', '09987654111', 'Croatian', 0),
	('Mato', 'Matic', '10', '018', '09587654223', 'Croatian', 0),
	('Petar', 'Peric', '21', '019', '09287654131', 'Croatian', 1)
--
insert into VisitorStays(VisitorId, StayId) VALUES
	(1,1),
	(2,1),
	(3,1),
	(4,2),
	(5,3),
	(6,6)
--sve sobe hotela 'Lav' poredane po broju
select * from Rooms where HotelId in (select Id from Hotels WHERE HotelName = 'Lav') order by Number 

--sve sobe ciji broj zapocinje jedinicom
select * from Rooms where Number like '1%'

--svi zaposlenici hotela 'Sirena' koji je pod rednim brojem 4
select * from Employees where HotelId = 4
--cistacice hotela 'Sirena' koji je pod rednim brojem 4
select FirstName, LastName from Employees where HotelId = 4 and Job = 'janitor'

--sve kupnje
select * from Reservations order by DateOfReservation desc
--kupnje ostvarene poslije 01.12.2020. i cija je cijena 1000+
select * from Reservations where DateOfReservation >= '2020-12-01' and Price > 1000

--boravci u svim hotelima
select * from Reservations where Id in (select Id from Stays) 
--boravci koji su trenutno u tijeku u svim hotelima
select * from Reservations where Id in (select Id from Stays) and ArrivalDate >= GETDATE() OR DepartureDate >= GETDATE()

--povijesni pregled rezervacija sobe pod rednim brojem 1
select * from Reservations where RoomId = 1
--povijesni pregled boravaka sobe pod rednim brojem 1
select * from Reservations where Id in (select Id from Stays) and RoomId = 1 order by ArrivalDate

--svi boravci hotela 'Lav' koji je pod rednim brojem 1
select * from Reservations where Id in (select Id from Stays) and RoomId in (select Id from Rooms where HotelId = 1)
--svi boravci hotela 'Lav' koji su bili pansion ili half pansion - buduci da su svi takvi mozemo isprobati ispisati samo pansione u iducem koraku
select * from Reservations where Id in (select Id from Stays) and RoomId in (select Id from Rooms where HotelId = 1) and TypeOfStay = 'pansion' OR TypeOfStay = 'half pansion'
--samo pansioni
select * from Reservations where Id in (select Id from Stays) and RoomId in (select Id from Rooms where HotelId = 1) and TypeOfStay = 'pansion'

--zelimo brisati sve boravke poslije 01.01.2020. , da bismo to mogli prvo ih treba izbrisati iz tablice VisitorStays pa iz tablice Stays 
select * from VisitorStays
delete from VisitorStays where StayId in (select Id from Reservations where ArrivalDate >= '2020-01-01')

select * from Stays where Id in (select Id from Reservations where ArrivalDate >= '2020-01-01') 
delete from Stays where Id in (select Id from Reservations where ArrivalDate >= '2020-01-01')
select * from Stays
--boravci su izbrisani, tablicu Reservations ne diramo

--mijenjamo kapacitet soba, hotela 'Zagreb' koji je pod rednim brojem 2, s 3 na 4 i shodno tome i kategoriju sobe
select * from Rooms where HotelId = 2
update Rooms set Capacity = 4 where HotelId = 2 AND Capacity = 3
update Rooms set Category = 'apartment' where HotelId = 2 AND Capacity = 4
select * from Rooms where HotelId = 2

--promoviramo 2 zaposlenika iz room service u recepcionist
select * from Employees where Job = 'room service'
UPDATE top(2) Employees set Job = 'recepcionist' where Job = 'room service'
select * from Employees where Job = 'room service'
select * from Employees where Job = 'recepcionist'


