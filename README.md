
# FlightBookingDB

## Overview
FlightBookingDB is a relational database system designed for managing flight bookings, passengers, payments, and airline schedules efficiently. It ensures seamless data handling for users, flight operations, reservations, and payments.

## Database Schema
The database consists of the following structured tables:
- **Users**: Stores user details and their role in the system.
- **Flights**: Manages flight schedules, airlines, and status updates.
- **Aircraft**: Contains aircraft model and capacity details.
- **Bookings**: Tracks flight bookings by users.
- **Payments**: Handles transaction details for bookings.
- **PassengersDetails**: Stores additional passenger data such as passport number and nationality.
- **Seats**: Manages seat assignments and availability for flights.
- **Baggage**: Stores passenger baggage information.
- **CheckIn**: Keeps records of passenger check-ins.
- **Reviews**: Tracks user reviews and ratings for flights.

## Installation & Setup
To set up the database:

1. **Create the database**
   ```sql
   CREATE DATABASE FlightBookingDB;
   USE FlightBookingDB;
