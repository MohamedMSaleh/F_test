# SpeakX - AI-Powered English Fluency Coach

SpeakX is an AI-powered English fluency coach tailored for Egyptian learners, focusing on speaking, pronunciation, and real-time feedback with optional human tutor validation and strict privacy controls.

## Features

### 🎯 Core Functionality
- **Speech Assessment**: Granular feedback on pronunciation, fluency, intonation, and interaction/emotion-confidence
- **Personalized Learning**: 4-week adaptive roadmap with exercises, quizzes, and recommendations
- **Gamification**: Progress tracking, badges, streaks, coins, leaderboards, and challenges
- **AI + Human Tutoring**: Conversation practice, story mode, reading, PDF practice, and human tutor validation
- **Error Clustering**: Pattern detection for targeted practice
- **Job Readiness**: Skills matching with employer offers
- **Privacy-First**: Encrypted storage with explicit consent and data controls

### 📱 Mobile & Web Support
- **Responsive Design**: Works perfectly on mobile devices and web browsers
- **Cross-Platform**: Single codebase for iOS, Android, and Web
- **Offline Support**: Practice continues even without internet connection
- **RTL Support**: Full Arabic language support with proper RTL layout

### 🏗️ App Architecture

#### Pages & Features (50+ Pages)
1. **Authentication & Onboarding**
   - Welcome, Sign-up, Consent, Mic Test, Tutorial
   
2. **Core Learning**
   - Home Dashboard, Learning Journey, Practice Exercises
   - Assessment (Onboarding & Ongoing), Reports, Recommendations
   
3. **Interactive Learning**
   - AI Tutor (Conversation, Story, Reading, PDF Practice)
   - Human Tutor (Booking, Task Queue, Live Sessions)
   - Challenges Hub, Leaderboards, Rooms
   
4. **Progress & Analytics**
   - Progress Tracking, Badges & Wallet, Streaks Coach
   - Micro-skills Browser, Error Clustering, Practice Packs
   
5. **Career Integration**
   - Job Recommendations, Employer Offers, Interview Prep
   - Mock Interviews, Career Planner, Negotiation Tools
   
6. **Communication**
   - Chat System, Notifications, Community Support
   
7. **Settings & Privacy**
   - Profile Management, Privacy Controls, Data Export/Deletion
   - Subscription Management, Accessibility Settings

### 🎨 Design System
- **Color Palette**: Indigo primary, Teal secondary, Gold accents
- **Typography**: Inter (English) / Cairo (Arabic) fonts
- **Spacing**: 4px base grid system
- **Components**: Reusable UI components with consistent styling
- **Accessibility**: WCAG AA compliance, RTL support, screen reader friendly

### 🔐 Privacy & Security
- **Explicit Consent**: Granular consent for voice recording, storage, and processing
- **Data Encryption**: All voice data encrypted with hashed IDs
- **Transparency**: Clear privacy policy and data handling explanations
- **User Control**: Data export, deletion, and consent management

### 🛠️ Technical Stack
- **Framework**: Flutter 3.x
- **State Management**: Provider
- **Navigation**: Go Router
- **Responsive UI**: ScreenUtil
- **Audio**: Record, Just Audio
- **Charts**: FL Chart
- **Storage**: Hive (local), Shared Preferences
- **Network**: Dio, HTTP
- **Permissions**: Permission Handler

## Getting Started

### Prerequisites
- Flutter SDK 3.0.0 or higher
- Dart SDK
- Android Studio / VS Code
- Android device/emulator or iOS device/simulator for mobile
- Chrome browser for web testing

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd speakx
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run code generation** (for Hive models)
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   
   For mobile:
   ```bash
   flutter run
   ```
   
   For web:
   ```bash
   flutter run -d chrome
   ```

### Configuration

1. **Assets Setup**
   - Add logo images to `assets/images/`
   - Add font files to `assets/fonts/`
   - Add audio samples to `assets/audio/`

2. **Permissions** (Android)
   Add to `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <uses-permission android:name="android.permission.RECORD_AUDIO" />
   <uses-permission android:name="android.permission.INTERNET" />
   ```

3. **iOS Configuration**
   Add to `ios/Runner/Info.plist`:
   ```xml
   <key>NSMicrophoneUsageDescription</key>
   <string>This app needs microphone access for speech assessment</string>
   ```

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── core/                        # Core app functionality
│   ├── theme/                   # App theme and design tokens
│   ├── router/                  # Navigation configuration
│   ├── providers/               # Global state providers
│   └── localization/           # Multi-language support
├── features/                    # Feature modules
│   ├── auth/                   # Authentication & onboarding
│   ├── home/                   # Home dashboard
│   ├── learning/               # Learning journey & roadmap
│   ├── assessment/             # Speech assessment
│   ├── challenges/             # Gamification & challenges
│   ├── tutor/                  # AI & Human tutoring
│   ├── rooms/                  # Practice rooms
│   ├── chat/                   # Messaging system
│   ├── progress/               # Progress tracking
│   ├── profile/                # User profile & settings
│   └── notifications/          # Notification system
```

## Key Features Implementation

### 🎯 Assessment System
- Multi-modal assessment (speaking, grammar, vocabulary)
- Real-time speech analysis with AI feedback
- Micro-skill detection and error clustering
- Adaptive recommendations based on performance

### 🤖 AI Tutoring
- Four practice modes: Conversation, Story, Reading, PDF Practice
- Live pronunciation feedback
- Transcript generation with word-level highlights
- Integration with error clustering for targeted practice

### 👨‍🏫 Human Tutoring
- Calendar-based session booking
- Async task queue for exercise review
- AI scores hidden from tutors for unbiased feedback
- Integration with learning roadmap

### 🏆 Gamification
- Weekly and monthly challenges
- Leaderboards with rank tracking
- Badge system with achievement unlocks
- Streak tracking with freeze tokens
- Virtual coin economy

### 🔒 Privacy Controls
- Granular consent management
- Data encryption and hashed IDs
- Export and deletion capabilities
- Transparent privacy policy integration

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Privacy & Ethics

SpeakX is built with privacy-first principles:
- Explicit consent for all voice data collection
- Encrypted storage with hashed user IDs
- Clear data handling transparency
- User control over data export and deletion
- Ethical AI development with bias mitigation

## Support

For questions or support:
- Email: support@speakx.ai
- Documentation: [docs.speakx.ai](docs.speakx.ai)
- Community: Join our practice rooms for peer support

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**SpeakX** - Empowering Egyptian learners to achieve English fluency with confidence and privacy. 🚀