# Indoz TV

## Project Overview

Indoz TV is a cross-platform mobile application designed to deliver live TV streaming, news articles, studio booking services, and interactive community content. The application is built using Flutter for seamless performance across Android and iOS platforms.

## Features

- **Live Streaming**: Stream live broadcast television and media content.
- **News & Articles**: Browse featured news stories and article detail views.
- **Studio Hire Services**: Submit inquiries and book studio space directly within the app.
- **Advertising Inquiries**: Request custom ad placements and commercial quotes.
- **Team & Member Showcase**: Explore team member profiles and organizational information.
- **User Management**: User registration, sign-in authentication, and profile editing.

## Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio / VS Code
- Xcode (for iOS)
- CocoaPods (for iOS)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/xtusharx1/IndozApp.git
   ```

2. Navigate to the project directory:
   ```bash
   cd android_app
   ```

3. Set up environment configuration:
   ```bash
   cp lib/src/utils/constants.dart.example lib/src/utils/constants.dart
   ```

4. Install dependencies:
   ```bash
   flutter pub get
   ```

## Running the App

### Android

```bash
flutter run
```

### iOS

```bash
cd ios
pod install
cd ..
flutter run
```

## Building

### Android APK

```bash
flutter build apk --release
```

### Android App Bundle

```bash
flutter build appbundle
```

### iOS

```bash
flutter build ipa
```

## Project Structure

- **lib/**: Contains the Flutter application source code including screens, models, services, themes, and utility classes.
- **assets/**: Contains static assets such as images, logos, and icon resources used in the application.
- **android/**: Native Android project files, Gradle configuration, and build scripts.
- **ios/**: Native iOS project files, Xcode configuration, and CocoaPods setup.

## Dependencies

Dependencies are managed using `pubspec.yaml`.

## License

Not specified
