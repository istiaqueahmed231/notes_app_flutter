# Todo Self (Notes App)

A Flutter application for managing personal notes. This app allows users to create, read, update, and delete notes, with data persisting locally using SQLite.

## Features

- **Create Notes**: Add new notes with a title, description, and date.
- **View Notes**: See a list of all your saved notes.
- **Edit Notes**: Update the content of existing notes.
- **Delete Notes**: Remove notes you no longer need.
- **Local Storage**: Notes are saved locally on the device using SQLite, so they persist even after the app is closed.

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **Language**: [Dart](https://dart.dev/)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Database**: [sqflite](https://pub.dev/packages/sqflite)
- **Path Provider**: [path_provider](https://pub.dev/packages/path_provider)

## Project Structure

The project follows a clean architecture pattern:

- **lib/Models**: Data models (e.g., `Note.dart`).
- **lib/Views**: UI screens (`HomePage`, `AddNotePage`, `EditNotePage`, `NotePage`).
- **lib/Providers**: State management logic (`NoteProvider`).
- **lib/Repositories**: Data access layer (`NoteRepository`).
- **lib/Services**: External services and database handling (`DbHelper`).

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
- An IDE (VS Code, Android Studio, or IntelliJ) with Flutter and Dart plugins.
- An Android/iOS emulator or a physical device.

### Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/todo_self.git
    cd todo_self
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Run the app:**

    ```bash
    flutter run
    ```

## Usage

1.  Launch the app on your device or emulator.
2.  Tap the **+** icon in the app bar to add a new note.
3.  Tap on the **Edit** (pencil) icon next to a note to modify it.
4.  Tap on the **Delete** (trash can) icon next to a note to remove it.
