# Flutter Firebase Authentication and Navigation App

A mobile application built with Flutter and Firebase Authentication, following the **MVVM (Model-View-ViewModel)** architecture with **BLoC** for state management. The app enables user registration, login, password reset, and navigation to a responsive home screen with a bottom navigation bar. It provides real-time feedback via SnackBars (e.g., "Sending password reset email..." on Forgot Password) and a seamless user experience across mobile, tablet, and desktop devices.

## Features
- **User Authentication**: Register, log in, and reset passwords using Firebase Authentication.
- **Password Reset Feedback**: Immediate "Sending password reset email..." SnackBar when clicking "Forgot Password?".
- **Responsive UI**: Adapts to mobile (<600px), tablet (<1200px), and desktop (≥1200px) screen sizes.
- **Navigation**: Home screen with a bottom navigation bar for tabbed navigation (e.g., Home, Profile, Settings).
- **Logout Functionality**: Log out from any screen and return to the login screen.
- **Error Handling**: User-friendly SnackBars for validation errors and Firebase authentication issues.
- **Architecture**: Implements MVVM with BLoC for robust state management.

## Project Setup
### Prerequisites
- **Flutter SDK**: Version 3.x.x (install from [flutter.dev](https://flutter.dev/docs/get-started/install)).
- **Dart**: Version 3.x.x (included with Flutter).
- **Firebase Project**: Create a project in the [Firebase Console](https://console.firebase.google.com/).
- **IDE**: Android Studio, VS Code, or any IDE with Flutter support.
- **Git**: For cloning the repository.
- **Android Device/Emulator**: For testing the app.

### Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/<your-username>/flutter-firebase-auth-app.git
   cd flutter-firebase-auth-app