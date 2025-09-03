# Messenger Apps

A modern real-time messaging and video calling application built with Flutter, featuring seamless chat functionality and high-quality video calls powered by WebRTC and Firebase.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)
![WebRTC](https://img.shields.io/badge/WebRTC-333333?style=for-the-badge&logo=webrtc&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

## 📱 Features

- **Real-time Messaging**: Instant text messaging with message delivery status
- **Video & Audio Calling**: High-quality WebRTC-powered video and audio calls
- **User Authentication**: Secure email/password authentication with Firebase Auth
- **User Profiles**: Customizable user profiles with image upload
- **Chat List**: View all conversations with last message preview
- **Online Status**: Real-time user presence and activity status
- **Firebase Integration**: Cloud Firestore for messaging and FCM for notifications
- **Clean Architecture**: MVVM pattern with proper separation of concerns
- **Responsive UI**: Optimized for different screen sizes using ScreenUtil

## 🏗️ Architecture

This project follows **Clean Architecture** principles with **MVVM (Model-View-ViewModel)** pattern:

```
lib/
├── core/                   # Core utilities and configurations
│   ├── config/            # App routes and global bindings
│   ├── constants/         # App constants and strings
│   ├── errors/           # Error handling
│   ├── theme/            # App theming
│   ├── usecases/         # Base use cases
│   ├── utils/            # Utility functions
│   └── widgets/          # Reusable widgets
├── features/             # Feature modules
│   ├── auth/             # Authentication feature
│   │   ├── data/         # Data sources and repositories
│   │   ├── domain/       # Entities and use cases
│   │   └── presentation/ # UI and ViewModels
│   ├── chat/             # Chat and calling feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── profile/          # User profile feature
│   └── welcome/          # Splash and onboarding
├── ui/                   # Additional UI components
└── main.dart            # App entry point
```

## 🚀 Getting Started

### Prerequisites

Before running this project, make sure you have:

- **Flutter SDK** (3.9.0 or higher)
- **Dart SDK** (3.9.0 or higher)
- **Android Studio** / **VS Code** with Flutter extensions
- **Firebase account** for backend services
- **Physical device** or emulator for testing (camera/microphone required for calls)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/adesh1145/messenger.git
   cd messenger
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate required files**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Firebase Setup**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable **Authentication** (Email/Password provider)
   - Enable **Cloud Firestore** database
   - Enable **Firebase Cloud Messaging** (FCM)
   - Download `google-services.json` for Android and place it in `android/app/`
   - Download `GoogleService-Info.plist` for iOS and place it in `ios/Runner/`

5. **Configure Firebase Security Rules**
   
   **Firestore Rules:**
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       // Users can read/write their own user document
       match /users/{userId} {
         allow read, write: if request.auth != null && request.auth.uid == userId;
       }
       
       // Chat rooms - users can read/write if they are participants
       match /rooms/{roomId} {
         allow read, write: if request.auth != null;
       }
       
       // Messages in chat rooms
       match /chats/{roomId}/messages/{messageId} {
         allow read, write: if request.auth != null;
       }
     }
   }
   ```

6. **Update Firebase Options**
   ```bash
   flutter pub global activate flutterfire_cli
   flutterfire configure
   ```

### Running the App

1. **Connect your device** or start an emulator

2. **Run the application**
   ```bash
   flutter run
   ```

3. **For release build**
   ```bash
   flutter build apk --release
   ```

## 📦 Dependencies

### Core Dependencies
- `flutter_webrtc: ^1.1.0` - WebRTC implementation for video calls
- `firebase_core: ^4.0.0` - Firebase core functionality
- `firebase_auth: ^6.0.1` - User authentication
- `cloud_firestore: ^6.0.0` - NoSQL database
- `firebase_messaging: ^16.0.1` - Push notifications

### State Management & Architecture
- `get: ^4.7.2` - State management and dependency injection
- `dartz: ^0.10.1` - Functional programming (Either type)

### UI & Utilities
- `flutter_screenutil: ^5.9.3` - Responsive screen adaptation
- `google_fonts: ^6.3.1` - Custom fonts
- `cached_network_image: ^3.4.1` - Image caching
- `image_picker: ^1.2.0` - Image selection
- `flutter_svg: ^2.2.0` - SVG support

### Code Generation
- `freezed: ^3.2.0` - Data class generation
- `json_serializable: ^6.11.0` - JSON serialization
- `build_runner: ^2.7.0` - Code generation runner

## 🔧 Configuration

### Environment Setup

1. **Android Configuration**
   - Minimum SDK: 21
   - Target SDK: 34
   - Add internet and camera permissions in `android/app/src/main/AndroidManifest.xml`:
   ```xml
    <!-- Permissions -->
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.CHANGE_NETWORK_STATE" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.USE_FULL_SCREEN_INTENT" />

    <!-- Camera features -->
    <uses-feature android:name="android.hardware.camera" />
    <uses-feature android:name="android.hardware.camera.autofocus" />
   ```


## 📱 App Screens

1. **Splash Screen** - App initialization and Firebase setup
2. **Authentication**
   - Login Screen
   - Registration Screen
   - Forgot Password
3. **Main App**
   - Chat List Screen
   - Individual Chat Screen
   - Video/Audio Call Screen
   - User Profile Screen
   - Settings Screen

## 🔗 Download APK

You can download the latest APK from: [Google Drive Link](https://drive.google.com/drive/folders/1NvRuDvMAK6hheGR-oQvKpujRlBFj7v9D?usp=sharing)

## 🛠️ Development Commands

```bash
# Get dependencies
flutter pub get

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Clean project
flutter clean

# Run tests
flutter test

# Build for Android
flutter build apk --release

# Build for iOS
flutter build ios --release

# Analyze code
flutter analyze

# Format code
dart format .
```

## 🏃‍♂️ Usage

1. **Registration/Login**: Create an account or sign in with existing credentials
2. **Profile Setup**: Add your profile picture and personal information
3. **Start Chatting**: Search for users and start conversations
4. **Video Calls**: Tap the video call button during a chat to initiate a call
5. **Receive Calls**: Accept incoming calls with notification support

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Firebase team for excellent backend services
- WebRTC community for real-time communication protocols
- Flutter team for the amazing framework
- All open-source contributors whose packages made this project possible

## 📞 Contact

**Developer**: Adesh Kumar
- GitHub: [@adesh1145](https://github.com/adesh1145)
- Repository: [messenger](https://github.com/adesh1145/messenger)

## 🔮 Future Enhancements

- [ ] Group video calls
- [ ] Message encryption
- [ ] File sharing
- [ ] Voice messages
- [ ] Custom chat themes
- [ ] Message reactions
- [ ] Screen sharing during calls
- [ ] Call recording

---

**⭐ Star this repository if you found it helpful!**
