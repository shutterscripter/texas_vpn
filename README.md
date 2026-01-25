# Nexas VPN

![Flutter CI](https://github.com/shutterscripter/Texas_vpn/workflows/Flutter%20CI/badge.svg)

A modern, secure, and beautifully designed VPN application built with Flutter.

## Features

- 🔒 **Secure VPN Connection** - OpenVPN protocol support
- 🌍 **Multiple Server Locations** - Connect to servers worldwide
- 📊 **Network Details** - View your IP, ISP, location, and more
- 🎨 **Modern UI** - Beautiful dark theme with smooth animations
- ⚡ **Fast & Reliable** - Optimized for performance
- 📱 **Cross-Platform** - Built with Flutter for Android

## Screenshots

| Splash Screen                                   | Home Screen                                 | Server Selection                                            | Network Details                                        |
| ----------------------------------------------- | ------------------------------------------- | ----------------------------------------------------------- | ------------------------------------------------------ |
| ![Splash](assets/screenshots/splash_screen.png) | ![Home](assets/screenshots/main_screen.png) | ![Locations](assets/screenshots/select_location_screen.png) | ![Network](assets/screenshots/network_test_screen.png) |

## Getting Started

### Prerequisites

- Flutter SDK (3.24.5 or higher)
- Dart SDK
- Android Studio / VS Code
- Java 17

### Installation

1. Clone the repository:

```bash
git clone https://github.com/shutterscripter/Texas_vpn.git
cd Texas_vpn
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

### Building for Production

**Android APK:**

```bash
flutter build apk --release
```

**Android App Bundle:**

```bash
flutter build appbundle --release
```

## CI/CD

This project uses GitHub Actions for continuous integration and deployment:

- **Code Quality Checks**: Dart formatting and analysis
- **Automated Testing**: Unit and widget tests
- **Build Automation**: APK and App Bundle generation
- **Code Coverage**: Tracked with Codecov

The CI pipeline runs automatically on:

- Push to `main` branch
- Pull requests to `main` branch

## Project Structure

```
lib/
├── api/              # API services and network calls
├── constants/        # App constants and configurations
├── controllers/      # GetX controllers for state management
├── helpers/          # Helper utilities and functions
├── models/           # Data models
├── screens/          # UI screens
├── services/         # Business logic services
└── widget/           # Reusable widgets
```

## Technologies Used

- **Flutter** - UI framework
- **GetX** - State management and navigation
- **Hive** - Local storage
- **OpenVPN** - VPN protocol
- **Forui** - UI components
- **ScreenUtil** - Responsive design

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

**Developer**: Jayesh Chauhan  
**GitHub**: [@shutterscripter](https://github.com/shutterscripter)

---

Made with ❤️ using Flutter
