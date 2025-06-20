# Water Drinking Tracer

A cross-platform Flutter application that helps users track their daily water intake, stay hydrated, and maintain healthy habits.

---

## ✨ Features

* **Quick logging** – one-tap buttons for common amounts & a custom input dialog.
* **Daily progress ring** – colorful circular indicator shows percentage toward the goal.
* **Edit / delete entries** – swipe to delete or tap to adjust any record.
* **Custom daily goal** – set your personal target in millilitres or ounces (coming soon).
* **Light & Dark themes** – automatic system theme plus in-app toggle.
* **Local storage with Hive** – works fully offline; data persists between launches.
* **Push reminders** – scheduled notifications (to be implemented).
* **History charts** – visualize your hydration over days/weeks/months (to be implemented).

---

## 🏗️ Architecture & Tech Stack

| Layer            | Package / Tool                | Notes |
|------------------|--------------------------------|-------|
| UI               | Flutter + Material 3           | Responsive & colorful UI |
| State Management | `flutter_riverpod`             | Provider + Notifier pattern |
| Local DB         | `hive`, `hive_flutter`         | Lightweight key-value store |
| Notifications    | `flutter_local_notifications`  | Native Android/iOS scheduling |
| Charts           | `fl_chart`                     | History visualisation |
| Other UI         | `percent_indicator`, `intl`    | Progress ring & formatting |

Project structure:

```
lib/
├─ models/        // Hive adapters (WaterEntry, UserSettings)
├─ services/      // StorageService (Hive CRUD)
├─ providers/     // Riverpod providers & notifiers
├─ screens/       // HomeScreen (+future Settings, History)
├─ widgets/       // Reusable widgets (if any)
└─ main.dart      // App entry, theming & routing
```

---

## 🚀 Getting Started

1. **Install Flutter** (3.19+ recommended) – [docs](https://docs.flutter.dev/get-started/install).
2. **Clone repo**
```bash
git clone <repo-url>
cd my_app
```
3. **Install dependencies**
```bash
flutter pub get
```
4. **Generate Hive adapters**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
5. **Run the app**
```bash
flutter run            # choose device
```

### Android build prerequisites
• Android SDK + NDK 27 (`ndkVersion = 27.0.12077973`) – configured in `android/app/build.gradle.kts`.
• Core-library desugaring enabled for Java 8 back-ports.

---

## 📦 Release Build

```bash
flutter build apk           # Android
flutter build ios           # iOS (Mac only)
flutter build web           # Web release
```

---

## 🛠️ TODO / Roadmap

- [ ] Settings screen: goal, units, reminder times.
- [ ] Unit conversion between ml ↔ oz.
- [ ] History charts with filters.
- [ ] Notification scheduling & background handling.
- [ ] App icon & splash screen.
- [ ] Localization & accessibility polish.

Contributions & feedback are welcome! 🎉


A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
