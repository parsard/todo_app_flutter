# 📝 Flutter ToDo App

A simple yet powerful **ToDo app** built with **Flutter**, using **Provider** for state management, **Shared Preferences** for local data storage, and following the **MVVM (Model-View-ViewModel)** architecture for clean and scalable code organization.

## ✨ Features

- ✅ Add, edit, and delete todos
- 📋 Mark tasks as completed
- 💾 Persistent storage using Shared Preferences
- 💡 State management using Provider
- 📐 Clean MVVM architecture
- 📱 Responsive UI

## 🧠 Tech Stack

- **Flutter** – Cross-platform UI toolkit
- **Provider** – Lightweight state management
- **Shared Preferences** – Persistent local storage
- **MVVM Architecture** – Separation of concerns for maintainability and scalability

## 📂 Project Structure (MVVM)

lib/ ├── models/ # Data models │ └── todo.dart ├── views/ # UI screens │ └── home_view.dart ├── viewmodels/ # Business logic and state │ └── todo_viewmodel.dart ├── services/ # Local storage service │ └── shared_preferences_service.dart ├── widgets/ # Reusable widgets │ └── todo_tile.dart └── main.dart
