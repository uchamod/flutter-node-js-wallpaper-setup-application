# Flutter-Node.js-Wallpaper-Setup Application

This repository contains a full-stack application designed for managing wallpapers. The client-side is built with Flutter as a mobile application, and the backend is powered by a Node.js server with MongoDB as the database. The application also incorporates JWT authentication for secure user access.

## Features 🚀
- **Get Random Wallpapers**: 🎲 Fetch high-quality random wallpapers.
- **Search Wallpapers**: 🔍 Find wallpapers by specific keywords or categories.
- **Add to Favorites**: ❤️ Save wallpapers as favorites for easy access.
- **Set as Mobile Wallpaper**: 📱 Directly set wallpapers on your mobile device.
- **Secure Access**: 🔒 User authentication using JWT (JSON Web Tokens).

## Technologies Used 🛠️

### Frontend 🖼️
- **Framework**: Flutter
- **State Management**: Provider (or any state management tool of your choice)
- **HTTP Library**: `http` package for API communication

### Backend 🔧
- **Framework**: Node.js with Express.js
- **Authentication**: JWT for secure user sessions
- **Database**: MongoDB for data storage

### Deployment 🌐
- **Backend**: Deployed on [Platform/Service, e.g., AWS, Heroku]
- **Frontend**: Deployed as a Flutter mobile app (e.g., Play Store, APK distribution)

## Prerequisites ✅
- Flutter SDK installed for mobile development.
- Node.js and npm installed for backend development.
- MongoDB instance (local or cloud, e.g., MongoDB Atlas).

## Setup Instructions 📋

### Backend Setup 🖥️
1. Clone the repository:
   ```bash
   git clone https://github.com/<your-username>/flutter-node-js-wallpaper-setup-application.git
   cd flutter-node-js-wallpaper-setup-application/server
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Configure environment variables:
   - Create a `.env` file in the `server` directory and add:
     ```env
     PORT=3000
     MONGO_URI=<your-mongodb-connection-string>
     JWT_SECRET=<your-jwt-secret>
     ```
4. Start the server:
   ```bash
   npm start
   ```
   The backend will run on `http://localhost:3000` by default.

### Frontend Setup 📱
1. Navigate to the Flutter project:
   ```bash
   cd flutter-node-js-wallpaper-setup-application/client
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Configure the API endpoint:
   - Open `lib/config.dart` (or similar configuration file) and set the base URL for your backend:
     ```dart
     const String baseUrl = "http://<your-backend-host>:3000";
     ```
4. Run the app:
   ```bash
   flutter run
   ```

## API Endpoints 🌟
### Authentication 🔐
- **POST** `/api/auth/register`: Register a new user.
- **POST** `/api/auth/login`: Login with credentials.

### Wallpaper Management 🖼️
- **GET** `/api/wallpapers/random`: Fetch random wallpapers.
- **GET** `/api/wallpapers/search?query=<keyword>`: Search wallpapers.
- **POST** `/api/wallpapers/favorites`: Add a wallpaper to favorites.
- **GET** `/api/wallpapers/favorites`: Get all favorite wallpapers.

## Screenshots 📸
[Add screenshots of the application here]

## Contributing 🤝
Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a new branch for your feature/fix.
3. Commit your changes and push them to your fork.
4. Submit a pull request for review.

## License 📄
This project is licensed under the [MIT License](LICENSE).

---
Feel free to use and modify this application for your own purposes!
