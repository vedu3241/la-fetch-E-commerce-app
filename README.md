# La Fetch - Premium E-Commerce Application

[![Flutter Version](https://img.shields.io/badge/Flutter-%3E%3D%203.10.7-blue.svg)](https://flutter.dev)
[![GetX](https://img.shields.io/badge/State%20Management-GetX-purple.svg)](https://pub.dev/packages/get)
[![Hive](https://img.shields.io/badge/Local%20Storage-Hive-orange.svg)](https://pub.dev/packages/hive)
[![Aesthetics](https://img.shields.io/badge/Design-Noir%20%26%20%C3%89pure-black.svg)]()

**La Fetch** is a premium, dark-themed Flutter e-commerce application designed with modern aesthetics (Noir & Épure style). It features a sleek glassmorphic navigation interface, dynamic category filters, a robust shopping cart with local persistent storage, and highly refined profile views.

---

## 🎨 Visual Design & Aesthetics

The application follows the **"NOIR & ÉPURE"** design language:
- **Color Palette**: Deep dark tones, minimalist typography, and vibrant purple primary accents (`#8E66CF`).
- **Typography**: Complete application integration with the **Plus Jakarta Sans** font family via Google Fonts.
- **Micro-interactions**: Subtle glassmorphism, responsive navigation bar, and clean interactive elements to deliver a premium user experience.

---

## 🏗️ Architectural Choices

The project is structured using a **Feature-First / Feature-driven Clean Architecture**. This ensures modularity, high scalability, and strict separation of concerns.

```text
lib/
├── app/                  # Application configuration & styling
│   ├── routes/           # Routing configuration & route maps (GetX)
│   └── theme/            # Color palettes, text styles, and global themes
│
├── data/                 # Data access layer
│   ├── models/           # Data models (Product, CartItem)
│   └── repositories/     # Data sources & APIs (ProductRepo interacting with FakeStoreAPI)
│
└── features/             # Feature modules (Presentation Layer)
    ├── nav/              # Navigation frame (Glassmorphic Navigation Bar)
    ├── home screen/      # Home view, Product grids, Categories filter, Hero Section
    ├── product details/  # Detailed product view with custom interactive sections
    ├── cart/             # Shopping cart screen & state controller
    ├── favourites/       # Wishlist/Favorites listing and state handling
    └── profile/          # User account views following the "Noir & Épure" guidelines
```

### Key Architectural Layers:
1. **Presentation Layer (`features/`)**: Every feature is self-contained with its own views, custom widgets, bindings, and GetX controllers. This prevents features from polluting each other's scopes.
2. **Data Layer (`data/`)**: Handles serialization and deserialization (JSON mapping) and network operations. The repository patterns decouple UI widgets from raw HTTP client implementations.
3. **Application Configuration (`app/`)**: Centralizes cross-cutting concerns like navigation routing paths and application themes.

---

## ⚡ State Management & Storage Solution

To provide a lightning-fast, reactive, and persistent user experience, the application utilizes a hybrid state management and storage strategy:

### 1. **GetX State Management & Dependency Injection**
- **Reactive UI**: State variables use observables (`.obs`, `RxList`, `RxBool`) to trigger automatic, precise widget rebuilds without manual lifecycle handling.
- **Dependency Injection**: Decoupled initialization via GetX `Bindings`. For example, repository files and controllers are instantiated lazily or globally using `Get.put()` and `Get.lazyPut()` when transitioning routes, managing resources efficiently.
- **Navigation & Routing**: Utilizes `GetMaterialApp` and `GetPage` definitions for seamless named route navigation, transitions, and middleware capabilities.

### 2. **Hive Local Persistence**
- **Persistence Layer**: To ensure the user's cart is not lost when closing the app, **Hive** (a lightweight, no-SQL key-value database written in pure Dart) is used.
- **Operations**:
  - The cart state resides in a Hive box named `cart_box`.
  - When the cart modifies (items added, removed, or quantity altered), the `CartController` serializes items to JSON maps and commits them locally.
  - Upon startup, the controller loads and deserializes items to populate the reactive list.

### 3. **Networking**
- Fetches real-time product catalogs and categories from the public [Fake Store API](https://fakestoreapi.com/) using standard HTTP client modules wrapped in repository wrappers.

---

## 🚀 Getting Started & Run Instructions

Follow the steps below to setup and run the project locally.

### Prerequisites
Make sure you have installed:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>= 3.10.7`)
- [Dart SDK](https://dart.dev/get-started)
- IDE (VS Code or Android Studio) with Flutter & Dart extensions
- Target device (Android Emulator, iOS Simulator, or connected Physical Device)

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/vedu3241/la-fetch-E-commerce-app.git
   cd la-fetch-E-commerce-app
   ```

2. **Retrieve Flutter Dependencies**
   ```bash
   flutter pub get
   ```

3. **Check Target Devices**
   Verify that a device/emulator is connected:
   ```bash
   flutter devices
   ```

4. **Run the Application**
   Launch the application in debug mode:
   ```bash
   flutter run
   ```

5. **Build Release Packages (Optional)**
   - **For Android:**
     ```bash
     flutter build apk --release
     ```
   - **For iOS:**
     ```bash
     flutter build ipa --release
     ```
