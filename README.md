# 😂 Meme App

A modern Flutter-based Meme Sharing Application that allows users to browse, upload, and interact with memes in real-time. The app leverages **Firebase Firestore** for database management and **Supabase Storage** for storing and serving meme images efficiently.

## 🚀 Features

* 📱 Browse memes in a real-time feed
* 📤 Upload and share memes
* ☁️ Store meme images securely using Supabase Storage
* 🔄 Real-time data synchronization with Firebase Firestore
* 🎨 Clean and responsive user interface
* ⚡ Fast image loading and retrieval
* 📂 Cloud-based media management
* 🔍 Seamless user experience across devices

## 🛠️ Tech Stack

### Frontend

* Flutter
* Dart

### Backend & Cloud Services

* Firebase Firestore (Database)
* Supabase Storage (Image Storage)
* Firebase Core

## 🏗️ Architecture

```text
Flutter App
     │
     ├── Firebase Firestore
     │      └── Meme Metadata
     │          (Title, Description, Image URL, Timestamp)
     │
     └── Supabase Storage
            └── Meme Images
```

## 📂 Project Structure

```text
lib/
│
├── models/
│   └── meme_model.dart
│
├── services/
│   ├── firestore_service.dart
│   └── supabase_service.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── upload_screen.dart
│   └── meme_details_screen.dart
│
├── widgets/
│   └── meme_card.dart
│
└── main.dart
```

## 🔥 Firebase Setup

1. Create a Firebase Project.
2. Enable Firestore Database.
3. Download `google-services.json`.
4. Place it inside:

```text
android/app/google-services.json
```

5. Configure Firebase:

```bash
flutterfire configure
```

## ☁️ Supabase Setup

1. Create a Supabase Project.
2. Create a Storage Bucket (e.g., `memes`).
3. Set appropriate storage policies.
4. Add your Supabase URL and Anon Key to the application.
5. Configure image upload and retrieval through Supabase Storage.

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  firebase_core: ^latest
  cloud_firestore: ^latest
  supabase_flutter: ^latest
  image_picker: ^latest
```

## ▶️ Installation

Clone the repository:

```bash
git clone https://github.com/your-username/meme-app.git
```

Navigate to the project folder:

```bash
cd meme-app
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## 💡 How It Works

1. User selects an image from the device.
2. The image is uploaded to Supabase Storage.
3. Supabase returns a public image URL.
4. Meme information (title, description, image URL, timestamp) is stored in Firebase Firestore.
5. The home feed listens to Firestore streams and updates automatically whenever new memes are added.

## 🎯 Learning Outcomes

This project demonstrates:

* Flutter App Development
* Firebase Firestore Integration
* Supabase Storage Integration
* Real-Time Data Streaming
* Image Upload & Cloud Storage
* CRUD Operations
* State Management
* Responsive UI Design

## 🔮 Future Enhancements

* User Authentication
* Meme Categories
* Like & Comment System
* User Profiles
* Search & Filtering
* Dark Mode
* Meme Sharing to Social Media

## 👨‍💻 Author

**Parth Rastogi**

BCA Student | Flutter Developer | Firebase & Supabase Enthusiast

## 📜 License

This project is licensed under the MIT License.

---

