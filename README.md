# Flutter Authentication Test Task
A Flutter application demonstrating authentication functionality with clean architecture principles.

https://github.com/user-attachments/assets/027dce12-2af0-4d8f-847f-abadba7abf2d

# 📥 Download
-  **Android** [Latest Release](https://github.com/Gj1337/flutter_redrocket_test_task/releases/latest/)

## 🏗️ Architecture
Clean Architecture with:
- **Presentation**: UI, BLoC/Cubit state management
- **Domain**: Business logic, entities, repository interfaces  
- **Data**: API calls, storage, repository implementations
- **DI**: `get_it` + `injectable` dependency injection

### 📁 Folder Structure
```
src/
├── data/
│   ├── datasource/     # API clients (AuthDatasource, MockAuthDatasource)
│   ├── entity/         # Data transfer objects (LoginRequest, LoginResponse)
│   ├── handlers/       # Token management (AuthHandler)
│   ├── repository/     # Repository implementations
│   └── utils/          # HTTP interceptors
├── domain/
│   ├── entity/         # Business entities (User, AuthStatus, exceptions)
│   └── repository/     # Repository interfaces
├── presentation/
│   ├── cubit/          # State management (AuthCubit, AuthState)
│   ├── features/       # Screens (LoginScreen, MainScreen)
│   ├── routes.dart     # Navigation setup
│   └── utils/          # UI utilities (DiProvider, StreamListenable)
└── di/                 # Dependency injection setup
```

## 🚀 Getting Started
### Prerequisites
 Flutter SDK ^3.9.0 or use fvm.

### 🔧 Environment Setup
The app supports multiple environments. Run with environment configuration:
```bash
# Development environment
flutter run --dart-define=ENV=dev
# Test environment  
flutter run --dart-define=ENV=test
```

Create environment files:
- `env/.env.dev` - for development
- `env/.env.test` - for testing

Add your API endpoint in the environment files:
```
API_ENDPOINT=your_api_endpoint_here
```

## 🔐 Authentication Flow
**Components**: AuthCubit (state) → AuthRepository (logic) → AuthDataSource (API) + AuthInterceptor (HTTP middleware) + GoRouter (navigation)

### 🔑 Login Flow
1. **👤 User input**  
   - On the `LoginScreen`, user enters email & password.  
   - Form validation ensures correct email format and password length.

2. **⚡ State update**  
   - `AuthCubit.onLogIn()` is called.  
   - It emits `AuthState.loading`.

3. **📡 Repository request**  
   - `AuthRepository.logIn()` sends credentials to `AuthDatasource.login()`.  
   - Depending on the environment:
     - **🔧 dev** → request is sent to real API endpoint  
     - **🧪 test** → credentials are checked against mock accounts (`user1@test.com/password1`, `user2@test.com/password2`)

4. **📋 Response handling**  
   - **✅ On success:**  
     - `AuthHandler` stores the token and user securely.  
     - `AuthCubit` emits `AuthState.authenticated(user)`.  
     - BlockListener catch the state change and redirects to `MainScreen`.  
   - **❌ On error:**  
     - Custom exceptions are mapped (400 → Bad format, 401 → Wrong password, 404 → Account not found).  
     - `AuthCubit` emits `AuthState.error` followed by `AuthState.unauthenticated`.  
     - An error message is shown via `SnackBar`.
---
🔓 **Auth Token Usage**

Once a user is logged in, all subsequent requests that require authentication are automatically intercepted. The AuthInterceptor attaches the stored authentication token to the request headers, ensuring the user remains authenticated for further API calls.

---

### 🚪 Logout Flow
1. **👆 User action**  
   - On `MainScreen`, user taps **Log out**.

2. **⚡ State update**  
   - `AuthCubit.onLogOut()` is called.  
   - It triggers `AuthRepository.logOut()`.

3. **📡 Repository request**  
   - Token is removed from `AuthHandler`.  
   - `AuthDatasource.logout()` is executed (mock or real).  

4. **🔄 State transition**  
   - `AuthCubit` emits `AuthState.unauthenticated`.  
   - Router redirects back to `LoginScreen`.
5. **Unauthorized Handling** 
  - If any request returns a `401 Unauthorized status`, the app automatically performs a logout and redirects the user to the LoginScreen. This ensures the user is prompted to re-authenticate if their token has expired or is invalid.
