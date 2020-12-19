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
