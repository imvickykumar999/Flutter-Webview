## 📱 Flutter WebView App – Lightweight, Smart, and Customizable

[![image](https://github.com/user-attachments/assets/5d51a002-1329-4a74-82a0-ee6d649fea0f)](https://www.imvickykumar999.online/blogs/how-to-create-a-webview-app-in-flutter-beginner-friendly-guide/)

This is a beginner-friendly Flutter app that loads your website inside a WebView and enhances it with key app-like features. Built using `webview_flutter`, it supports navigation, link handling, clipboard actions, and seamless integration with external browsers.

---

### 🚀 Features

- ✅ **Website Integration with WebView**  
  Loads `https://imvickykumar999.online` directly in the app using Flutter WebView.

- 🔁 **Reload on Title Tap**  
  Tap the AppBar title to refresh the current page instantly.

- 📋 **Copy URL to Clipboard**  
  Click the copy icon in the AppBar to copy the current page's URL, with a confirmation snackbar.

- 🌐 **External Links Open in Default Browser**  
  Any links that lead outside your domain (e.g., Twitter, Facebook, YouTube) are automatically opened in the device’s default browser — not inside the app or Chrome Custom Tabs.

- 🔙 **Back Navigation within WebView**  
  Uses `PopScope` to intercept back button presses and navigate WebView history instead of exiting the app immediately.

- 🌍 **Full JavaScript Support**  
  Uses `JavaScriptMode.unrestricted` to enable all website functionality including modern web features.

- 🎯 **Dynamic AppBar Title and URL**  
  Updates page title and current URL dynamically as users navigate through the website.

- 🛡️ **Error Handling for External URLs**  
  If no app can handle an external URL, the user is informed with a user-friendly message.

---

### 📂 Folder Overview

```
lib/
 └── main.dart          # Core app file with WebView integration and URL launcher
android/
 └── ...                # Native Android settings and permissions
build/
 └── ...                # Auto-generated after builds
```

---

### 🛠️ Build Instructions

Use these commands in your terminal or CMD from the root of your Flutter project:

#### 📦 Create Android App Bundle (AAB)
For uploading to Google Play Store:
```bash
flutter build appbundle
```
> Output: `build/app/outputs/bundle/release/app-release.aab`

---

#### 🟢 Create Release APK
Ideal for distribution or testing:
```bash
flutter build apk --release
```
> Output: `build/app/outputs/flutter-apk/app-release.apk`

---

#### 🟡 Create Debug APK
Useful for testing and debugging:
```bash
flutter build apk --debug
```
> Output: `build/app/outputs/flutter-apk/app-debug.apk`

---

### 📋 Notes

- Ensure your `AndroidManifest.xml` includes:
  ```xml
  <uses-permission android:name="android.permission.INTERNET" />
  ```
- The app respects your domain (`imvickykumar999.online`) and opens all others in an external browser using `url_launcher`.

---

### 👨‍💻 Ideal For

- Web developers converting a blog or portfolio into an app  
- Businesses looking to create lightweight app wrappers  
- Educational or personal experiments with WebView in Flutter

![WhatsApp Image 2025-04-18 at 5 12 00 PM](https://github.com/user-attachments/assets/d4eba6ef-baa8-4fde-a3c2-f97ede49a6d6)

### 📃 License

This project is open-source and free to use under the MIT License.
