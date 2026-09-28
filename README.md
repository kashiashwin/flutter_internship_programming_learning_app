# 📱 INOVIQ — Programming Learning App

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-2.17+-0175C2?style=flat-square&logo=dart)
![SQLite](https://img.shields.io/badge/SQLite-sqflite-003B57?style=flat-square&logo=sqlite)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

**Learn to code. Beautifully.**  
INOVIQ is a fully offline, self-contained Flutter mobile application that serves as a programming-learning companion for beginners. Built entirely from scratch during an internship programme, it delivers a complete end-to-end user journey — from splash screen to account management — all running locally on a single Android device with no server or internet dependency.

---

## ✨ Features

### 📚 8 Programming Courses
| Course | Description |
|--------|-------------|
| **Django** | High-level Python web framework |
| **Python** | Beginner-friendly general-purpose language |
| **C++** | High-performance systems language |
| **Java** | Class-based, object-oriented language |
| **Flutter** | Google's UI toolkit for native apps |
| **Web Development** | HTML, CSS, JavaScript & beyond |
| **Game Development** | Unity & C# game engine basics |
| **DevOps** | CI/CD, Docker, Kubernetes & cloud |

Each course contains **10 structured lessons** with:
- 📖 Informative body text
- 💻 Dark-themed code snippet panels (selectable & copy-friendly)
- ✅ **Mark Complete** toggle per lesson
- 📊 **Live progress bar** tracking completion percentage
- 🏷️ **Sticky Table of Contents** for quick navigation between lessons
- 🔍 **Search** to filter courses by name

### 🔐 Complete Authentication Flow
- **Sign Up** — full client-side validation (email format, password length, confirm match)
- **Sign In** — authenticates against local SQLite database
- **Session Manager** — holds signed-in user in memory across screens
- **Sign Out** — clears session and returns to welcome screen
- **Delete Account** — permanent deletion with "type DELETE to confirm" safety check

### 👤 Profile Management
- View account details (username, email, gender, user ID)
- **Change profile photo** — pick from gallery with auto-copy to app's private directory
- **Change password** — verify current password, set new one with validation

### 🎨 Beautiful Material-3 UI
- Teal colour palette with Material Design 3
- **Google Fonts** — Aboreto for display text, Poppins for body text
- Rounded card geometry with soft shadows
- Gradient backgrounds and glow effects
- Animated transitions and micro-interactions
- Edge-to-edge immersive design

### 🗄️ Offline Local Database
- **SQLite** via `sqflite` — all data stored in `backend.db`
- Two tables: `users` (full profile) and `login` (authentication)
- Auto-migration with safety net for half-migrated databases
- Complete CRUD operations through `DatabaseHelper` abstraction

---

## 🏗️ Architecture

```
internship dart files/
├── welcome.dart           # App entry point & splash screen
├── sign_up.dart           # Registration screen with validation
├── Login.dart             # Sign-in screen (note: capital L)
├── home_page.dart         # Course catalogue grid with search
├── course_data.dart       # Course & CourseSection data models
├── course_detail_page.dart # Lesson detail with progress tracking
├── profile_page.dart      # User profile & photo management
├── settings_page.dart     # Log out & account deletion
├── about_page.dart        # App info & team credits
├── database_helper.dart   # SQLite database abstraction layer
├── session_manager.dart   # In-memory session state holder
├── edit_user_page.dart    # Admin: edit user records
├── view_data.dart         # Admin: view all registered users
```

### Data Flow
```
welcome.dart  ──────────►  sign_up.dart  ─────────────────┐
    │                        │                            │
    │                        ▼                            │
    └─────────────►  Login.dart  ◄── SuccessDialog ───────┘
                        │
                        ▼
                  home_page.dart
                  ┌────┴────┐
                  │         │
            (drawer)   (course grid)
         ┌────┼────┐       │
         │    │    │       ▼
   profile  settings  course_detail_page
   _page   _page      │
     │        │       ├── Lesson 1
     │        │       ├── Lesson 2
     │        │       └── ...
     │        │
     ▼        ▼
  (logout/delete) ──► welcome.dart (session cleared)
```

### Database Schema
```
users                          login
┌──────────────────────┐       ┌──────────────────┐
│ id (PRIMARY KEY)     │       │ id (PRIMARY KEY) │
│ username             │       │ email             │
│ email                │       │ password          │
│ gender               │       └──────────────────┘
│ password             │
│ confirm_password     │
│ profile_photo        │
└──────────────────────┘
```

---

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| **Flutter 3.x** | Cross-platform UI framework |
| **Dart 2.17+** | Programming language |
| **sqflite** | On-device SQLite database |
| **google_fonts** | Aboreto + Poppins typography |
| **image_picker** | Gallery photo selection |
| **path_provider** | Stable app documents directory |
| **path** | File path manipulation |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.x or later)
- Dart SDK (2.17 or later)
- Android Studio / VS Code with Flutter extension
- An Android device or emulator

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/yourusername/inoviq-learning-app.git
cd inoviq-learning-app

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

> **Note:** The app runs entirely offline — no API keys, no server setup, no internet connection required.

### Project Configuration
Ensure your `pubspec.yaml` includes these dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0
  path: ^1.8.0
  path_provider: ^2.1.0
  google_fonts: ^6.1.0
  image_picker: ^1.0.0
```

Assets needed:
```yaml
flutter:
  assets:
    - assets/images/logo.jpg
    - assets/images/comp_logo.png
    - assets/icons/
```

---

## 📸 Screenshots

| Screen | Preview |
|--------|---------|
| **Welcome** | Dark splash with INOVIQ branding |
| **Sign Up** | Registration form with gender selector |
| **Sign In** | Login form with validation |
| **Home** | Course catalogue grid with search |
| **Course Detail** | Lessons, progress bar, code snippets |
| **Profile** | Photo, details, change password |
| **Settings** | Log out & delete account |
| **About** | App info & team credits |

*(Screenshots available in the `ss/` directory of this repository)*

---

## 🧪 Key Features in Detail

### Validation Rules (Sign Up)
- All fields required
- Email must contain `@` and `.`
- Password minimum 6 characters
- Passwords must match
- Gender selection (Male / Female / Other)

### Session Management
- `SessionManager` static class holds the signed-in user in memory
- Available globally to all screens without prop drilling
- Cleared on logout or account deletion

### Photo Handling
- Gallery picker copies selected image to app's private documents directory
- Old photo automatically deleted when a new one is chosen
- Prevents Android 13+ temporary URI permission revocation

### Account Deletion Safety
- Requires typing "DELETE" in a confirmation field
- Deletes rows from both `users` and `login` tables
- Clears session and navigates back to welcome screen

---

## 👥 Team

| Name | Role |
|------|------|
| **Jessa Jaison** | Team Member |
| **Anzil T Z** | Team Member |
| **Abishek P Prasad** | Team Member |
| **Ashwin T S** | Team Member |
| **Ahnas Mohammed P.M** | Project Manager |
| **Fathahiya Shirin P.M** | Project Manager |
| **Mohammed Sharafas P.M** | Project Manager |

---

## 📄 License

This project is developed as part of an internship programme.  
© 2026 INOVIQ — Built with ♥ by the Internship Team

---

## 🙏 Acknowledgements

- **Flutter & Dart** teams for the amazing framework
- **Google Fonts** for the beautiful typography
- All team members and project managers for their contributions
- Internship coordinators for guidance and support
#   i n o v i q - w e b s i t e  
 