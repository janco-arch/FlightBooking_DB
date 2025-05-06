create database FlightBookingDB;
use FlightBookingDB;

create table Users(
UserID int primary key auto_increment,
FullName varchar(255) not null,
Email varchar(100) unique not null,
PhoneNumber int,
PasswordHash varchar(255) not null,
userType enum("Passenger", "Admin", "Agent")
);


INSERT INTO Users (FullName, Email, PhoneNumber, PasswordHash, UserType) VALUES
('Alice Kim', 'alice.kim@example.com', '0720001000', 'hashed_password_1', 'Passenger'),
('John Doe', 'john.doe@example.com', '0723456789', 'hashed_password_2', 'Passenger'),
('Sarah Johnson', 'sarah.j@example.com', '0712345678', 'hashed_password_3', 'Admin'),
('Mark Spencer', 'mark.spencer@example.com', '0709876543', 'hashed_password_4', 'Agent');


create table Flights(
FlightID int primary key auto_increment,
AirLine  varchar(100) not null,
FlightNumber varchar(20)unique not null,
DepartureAirport varchar(100) not null,
ArrivalAirport varchar(100) not null,
DepartureTime datetime not null,
ArrivalTime datetime not null,
AvailableSeats int not null,
status enum("Scheduled", "Delayed", "Cancelled", "Completed") not null
);


INSERT INTO Flights (Airline, FlightNumber, DepartureAirport, ArrivalAirport, DepartureTime, ArrivalTime, AvailableSeats, Status) VALUES
('Kenya Airways', 'KQ100', 'Jomo Kenyatta International Airport', 'Heathrow Airport', '2025-05-10 14:00:00', '2025-05-10 22:00:00', 200, 'Scheduled'),
('Emirates', 'EK404', 'Dubai International Airport', 'Jomo Kenyatta International Airport', '2025-06-01 10:30:00', '2025-06-01 15:00:00', 250, 'Scheduled'),
('Qatar Airways', 'QR203', 'Doha International Airport', 'O.R. Tambo International Airport', '2025-07-15 08:00:00', '2025-07-15 16:00:00', 180, 'Delayed');




create table Aircraft(
AircraftID int primary key auto_increment,
Model varchar(50) not null,
Capacity int,
AirLine varchar(100) not null,
FlightID int
);

INSERT INTO Aircraft (Model, Capacity, Airline) VALUES
("Boeing 787 Dreamliner", 250, "Kenya Airways"),
("Airbus A380", 600, "Emirates"),
("Boeing 737", 180, "Qatar Airways");


create table Bookings(
BookingID int primary key auto_increment,
UserID int not null,
FlightID int not null,
BookingDate timestamp default current_timestamp,
BookingStatus enum("Confirmed", "Cancelled", "Pending") not null,
foreign key (UserID) references Users(UserID),
foreign key (FlightID) references Flights(FlightID)
);

INSERT INTO Bookings (UserID, FlightID, BookingDate, BookingStatus) VALUES
(1, 1, "2025-04-25", "Confirmed"),
(2, 2, "2025-04-26", "Pending"),
(3, 3, "2025-04-27", "Cancelled");



create table Payments(
PaymentID int primary key auto_increment,
BookingID int not null,
Amount decimal(10, 2) not null,
PaymentDate timestamp default current_timestamp,
PaymentMethod enum("Credit Card", "Debit Card", "PayPal", "Mobile Money") not null,
PaymentStatus enum("Successful", "Pending", "Failed") not null,
foreign key (BookingID) references Bookings(BookingID)
);


INSERT INTO Payments (BookingID, Amount, PaymentDate, PaymentMethod, PaymentStatus) VALUES
(1, 1200.50, "2025-04-25 12:45:00", "Credit Card", "Successful"),
(2, 850.75, "2025-04-26 14:10:00", "Mobile Money", "Pending"),
(3, 650.00, "2025-04-27 09:15:00", "Debit Card", "Failed");



create table PassengersDetails(
PassengerID int primary key auto_increment,
UserID int not null,
PassportNumber varchar(50) unique not null,
Nationality varchar(50),
DateOfBirth date not null,
foreign key (UserID) references Users(UserID)
);

INSERT INTO PassengersDetails (UserID, PassportNumber, Nationality, DateOfBirth) VALUES
(1, "12345678", "Kenyan", "1995-06-12"),
(2, "B23456789", "American", "1988-11-23"),
(3, "C34567890", "British", "1979-05-04");


create table Seats(
SeatID int primary key auto_increment,
FlightID int not null,
SeatNumber varchar(10) unique not null,
SeatClass enum("Economy", "Business", "First Class") not null,
IsAvailable boolean default true,
foreign key (FlightID) references Flights(FlightID)
);

INSERT INTO Seats (FlightID, SeatNumber, SeatClass, IsAvailable) VALUES
(1, "12A", "Business", FALSE),
(1, "23B", "Economy", TRUE),
(2, "5F", "First Class", TRUE);


create table Baggage(
BaggageID int primary key auto_increment,
PassengerID int not null,
Weight decimal(5, 2) not null,
BaggageType enum("Carry-On", "Checked") not null,
foreign key (PassengerID) references PassengersDetails(PassengerID)
);

INSERT INTO Baggage (PassengerID, Weight, BaggageType) VALUES
(1, 15.5, "Checked"),
(2, 7.0, "Carry-on"),
(3, 20.0, "Checked");


create table CheckIn(
CheckInID int primary key auto_increment,
BookingID int not null,
CheckInStatus enum("Checked In", "Not Checked-In") not null,
CheckInTime timestamp default current_timestamp,
foreign key (BookingID) references Bookings(BookingID)
);

INSERT INTO CheckIn (BookingID, CheckInStatus, CheckInTime) VALUES
(1, 'Checked In', '2025-05-10 12:00:00'),
(2, 'Not Checked-In', NULL);


create table Reviews(
ReviewID int primary key auto_increment,
UserID int not null,
FlightID int not null,
Rating int check (Rating between 1 and 5),
Comment text,
ReviewDate timestamp default current_timestamp,
foreign key (UserID) references Users(UserID),
foreign key (FlightID) references Flights(FlightID)
);


INSERT INTO Reviews (UserID, FlightID, Rating, Comment, ReviewDate) VALUES
(1, 1, 5, 'Great flight, smooth experience!', '2025-05-11 10:00:00'),
(2, 2, 3, 'Decent service but slight delay', '2025-06-02 14:30:00');
