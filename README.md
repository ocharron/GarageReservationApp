# Garage Reservation App - Car Service Appointment Booking

[![en](https://img.shields.io/badge/lang-en-red.svg)](https://github.com/ocharron/GarageReservationApp/blob/main/README.md)
[![fr](https://img.shields.io/badge/lang-fr-blue.svg)](https://github.com/ocharron/GarageReservationApp/blob/main/README_fr.md)

Garage Reservation App is a fictive application built to streamline the booking of automotive services at your local garage. With this app, customers can easily schedule appointments based on mechanics' availabilities.

---

## Technologies Used

- **Framework**: Flutter
- **Database**: SQLite (sqflite)
- **State management**: Provider

---

## Installation

To install and run Garage Reservation App on your local machine, please follow these steps:

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/)
- An emulator or a physical device to run the app

### Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/ocharron/GarageReservationApp.git
   ```

2. **Install dependencies**
   - Navigate to the project directory and run the following command to install dependencies:
     ```bash
     flutter pub get
     ```
   - Update the connection string in the `appsettings.json` file with your database details.
   - Execute a Migration and an Update-Database. (Code First)

3. **Set up the database**
   - The app uses SQLite for local storage, which is handled through the sqflite package.
   - The database will be created automatically on the first run. You don't need to manually configure it.

4. **Running the app**
   - To run the app, use the following command:
     ```bash
     flutter run
     ```
   - You can also run the app on a connected device or emulator.

---

## Key Features

1. **Availabilities Management**: Mechanics can enter their available hours for appointments, ensuring customers can only book during those times.
2. **Appointment scheduling**: Customers can view the mechanics' availabilities and schedule appointments based on their preferred time slots.
3. **Authentication with Auth0**: Secure user authentication using Auth0 to manage user sessions and profiles.
4. **Dark mode**: The app provides a dark mode for a comfortable viewing experience in low-light environments.

---

## Author

This project was developed by [Olivier Charron](https://github.com/ocharron)