# Smart Meter App

[![Flutter](https://img.shields.io/badge/Flutter-Framework-blue)](https://flutter.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Android%20|%20iOS-lightgrey)](#)
[![Firebase](https://img.shields.io/badge/Backend-Firebase-orange)](https://firebase.google.com/)
[![The Things Network](https://img.shields.io/badge/IoT-The%20Things%20Network-blueviolet)](https://www.thethingsnetwork.org/)

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Architecture](#architecture)
- [Technologies Used](#technologies-used)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

---

## Overview

The **Smart Meter App** is a Flutter-based mobile application designed to interact with a custom-built smart meter device. The app provides users with real-time and historical power consumption data, making it easier to monitor and manage energy usage effectively. By leveraging LoRaWAN technology and integrating with The Things Network API, the app retrieves data from deployed smart devices and presents it in an intuitive and user-friendly interface.

---

## Features

- **Real-Time Data Visualization**
  - View instantaneous power, current meter readings, and maximum power usage.
  - Home screen widgets displaying units consumed and instantaneous power stats.

- **Historical Data Analysis**
  - Daily, weekly, monthly, and yearly power consumption graphs.
  - Downloadable reports of last month's bill and current month bill.

- **Predictive Analytics**
  - Compute expected bill and units using a regression algorithm based on current month's usage.

- **User Account Management**
  - Secure authentication using Firebase.
  - Persistent login sessions unless the user chooses to log out.
  - Personalization of app settings and preferences.

- **Notifications**
  - Enable daily consumption notifications to stay updated on power usage.

- **Billing Information**
  - View current month's bill status (paid or unpaid).
  - Access to last bill details and download options.

- **Integration with The Things Network**
  - Seamless communication with smart meter devices via LoRaWAN technology.
  - Data retrieval through The Things Network API.

- **Availability**
  - The app is available on the [Google Play Store](#) for easy access.

---

## Screenshots

*(Screenshots of the app's main screens and features can be added here.)*

---

## Getting Started

### Prerequisites

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install) on your development machine.
- **Firebase Account**: Set up a [Firebase](https://firebase.google.com/) project for authentication and data storage.
- **The Things Network Account**: Access to [The Things Network](https://www.thethingsnetwork.org/) for API integration.
- **Android/iOS Device or Emulator**: To run and test the application.

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/smart-meter-app.git
   cd smart-meter-app
   ```

2. **Install Dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure Firebase**

   - Replace the `google-services.json` file in `android/app/` with your own from your Firebase project.
   - Replace the `GoogleService-Info.plist` file in `ios/Runner/` with your own.

4. **Configure The Things Network API**

   - Update the API endpoints and authentication keys in the app's configuration files.

5. **Run the App**

   ```bash
   flutter run
   ```

---

## Architecture

The app follows a **Model-View-Controller (MVC)** architecture, ensuring a clear separation of concerns:

- **Model**: Represents the data layer, including user data, power consumption records, and billing information.
- **View**: The UI components built using Flutter widgets, providing a responsive and interactive user interface.
- **Controller**: Handles the business logic, including API calls to The Things Network, data processing, and communication between the Model and View.

---

## Technologies Used

- **Flutter**: For cross-platform mobile app development.
- **Firebase**: For authentication and cloud storage.
- **LoRaWAN Technology**: For wireless communication with smart meter devices.
- **The Things Network API**: To access data from deployed devices.
- **Regression Algorithms**: For predictive analytics on power consumption and billing.
- **Figma**: For UI/UX design (Design files available upon request).

---

## Usage

1. **Authentication**

   - Open the app and sign up using your email and password.
   - Firebase handles user authentication and session management.

2. **Dashboard**

   - View real-time power consumption data.
   - Access widgets showing instantaneous power and units consumed.

3. **Historical Data**

   - Navigate to the graphs section to view daily, weekly, monthly, and yearly consumption.
   - Analyze usage patterns and identify opportunities for energy savings.

4. **Billing**

   - Check the status of your current month's bill.
   - Download the last month's bill and current month bill directly from the app.

5. **Notifications**

   - Enable daily consumption notifications in the settings to receive regular updates.

6. **Settings**

   - Customize app preferences and manage your account information.

---

## Contributing

We welcome contributions from the community to enhance the functionality and features of the Smart Meter App.

1. **Fork the Repository**

   Click on the "Fork" button at the top right corner of the repository page.

2. **Create a Branch**

   ```bash
   git checkout -b feature/YourFeatureName
   ```

3. **Commit Your Changes**

   ```bash
   git commit -m "Add Your Feature"
   ```

4. **Push to the Branch**

   ```bash
   git push origin feature/YourFeatureName
   ```

5. **Create a Pull Request**

   Open a pull request to the `main` branch of the original repository.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Contact

For any inquiries or feedback, please contact:

- **Name**: Your Name
- **Email**: [your.email@example.com](mailto:your.email@example.com)
- **LinkedIn**: [Your LinkedIn Profile](https://www.linkedin.com/in/yourprofile)
- **GitHub**: [Your GitHub Profile](https://github.com/yourusername)

---

*Note: This app is open-source to facilitate learning and encourage contributions. By sharing this project, we hope others can benefit from our work and help improve it further.*
