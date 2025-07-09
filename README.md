# 📝 Flutter Notes App – Individual Assignment 2

The Flutter notes app was created as a part of **Individual Assignment 2**.  
It enables users to create accounts, log in, and use **Firebase Authentication** and **Cloud Firestore** to complete all CRUD (Create, Read, Update, Delete) activities on notes.

---

## 🚀 Features

- Email/Password sign-up and login  
- Create, edit, and delete notes  
- Real-time Firestore sync  
- SnackBars for success and error messages  
- Clean architecture using Cubit  
- Responsive layout with rotation support  

---

## 🧱 Folder Structure

```
lib/
├── cubit/       # Cubit state management logic
├── models/      # Note model
├── screens/     # Login, Signup, Home UIs
├── services/    # Firebase auth and Firestore handlers
├── widgets/     # Reusable UI components (optional)
└── main.dart    # Entry point of the app
```


## 🔧 Firebase Setup (To Run This App)

1. Create a Firebase project on [console.firebase.google.com](https://console.firebase.google.com)  
2. Enable **Email/Password Authentication**  
3. Add a **Cloud Firestore** database  
4. Download `google-services.json` and place it in `android/app/`  
5. Update Firestore rules to:

```plaintext
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

Run the app:

```bash
flutter pub get
flutter run

📌 Author
Mairo Pedro Isaac