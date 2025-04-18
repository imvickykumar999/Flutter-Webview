># 💡 `How to Create a WebView App in Flutter`
>
>[![image](https://github.com/user-attachments/assets/5d51a002-1329-4a74-82a0-ee6d649fea0f)](https://www.imvickykumar999.online/blogs/how-to-create-a-webview-app-in-flutter-beginner-friendly-guide/)

If you’re new to Flutter and want to create a simple **WebView app** that opens a website inside your mobile app, this guide is for you! We’ll cover everything from setting up Flutter to running your app on a real Android phone — no emulator required.

## ✅ Step 1: Set Up Flutter on Linux

If you haven't already, install Flutter using Snap:

```bash
sudo snap install flutter --classic
```

Then run:

```bash
flutter doctor
```

This checks your Flutter setup. Follow the on-screen tips to fix anything marked with a ❌.

---

## ✅ Step 2: Install Android SDK (No Android Studio Required)

Install the command-line Android tools:

```bash
mkdir -p ~/Android/cmdline-tools
cd ~/Android/cmdline-tools
wget https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip
unzip commandlinetools-linux-10406996_latest.zip
mv cmdline-tools latest
```

Add this to your `~/.bashrc`:

```bash
export ANDROID_HOME=$HOME/Android
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
```

Then run:

```bash
source ~/.bashrc
```

Install required SDK packages:

```bash
sdkmanager --licenses
sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.2"
```

---

## ✅ Step 3: Create a New Flutter Project

```bash
flutter create webview_app
cd webview_app
code .
```

This will open your new Flutter project in VS Code.

---

## ✅ Step 4: Add WebView Package

Edit your `pubspec.yaml` file and add:

```yaml
dependencies:
  webview_flutter: ^4.2.4
```

Then run:

```bash
flutter pub get
```

---

## ✅ Step 5: Add Internet Permission

Edit `android/app/src/main/AndroidManifest.xml` and add:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

Also, inside the `<application>` tag, add:

```xml
android:usesCleartextTraffic="true"
```

---

## ✅ Step 6: Replace `main.dart` with WebView Code

Open `lib/main.dart` and replace everything with:

```dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WebViewExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WebViewExample extends StatefulWidget {
  const WebViewExample({super.key});

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late final WebViewController _controller;
  String _currentUrl = "Loading...";
  String _pageTitle = "Loading...";

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
            Uri uri = Uri.parse(request.url);

            // Allow internal domain to load in WebView
            if (uri.host.contains('imvickykumar999.online')) {
              return NavigationDecision.navigate;
            }

            // Handle external links robustly
            await _launchExternalUrl(request.url, context);
            return NavigationDecision.prevent;
          },
          onPageStarted: (String url) {
            setState(() {
              _currentUrl = url;
              _pageTitle = "Loading...";
            });
          },
          onPageFinished: (String url) async {
            final updatedUrl = await _controller.currentUrl();
            final title = await _controller.getTitle();
            setState(() {
              _currentUrl = updatedUrl ?? 'Unknown URL';
              _pageTitle = title ?? 'No Title';
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("WebView Error: ${error.description}");
          },
        ),
      )
      ..loadRequest(Uri.parse("https://imvickykumar999.online/"));
  }

  // 🔗 External URL handler
  Future<void> _launchExternalUrl(String url, BuildContext context) async {
    try {
      final uri = Uri.parse(url);
      debugPrint("Trying to launch external URL: $url");

      // Attempt external app launch
      if (await canLaunchUrl(uri)) {
        final launched = await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication);
        if (!launched) {
          // Fallback to platform default
          await launchUrl(uri, mode: LaunchMode.platformDefault);
        }
      } else {
        // Fallback if no app found
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error opening URL: $e")),
      );
    }
  }

  // 📋 Copy current URL to clipboard
  void _copyUrlToClipboard() {
    Clipboard.setData(ClipboardData(text: _currentUrl)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("URL copied to clipboard")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          if (await _controller.canGoBack()) {
            _controller.goBack();
          } else {
            Navigator.of(context).maybePop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF04203F),
          iconTheme: const IconThemeData(color: Colors.white),
          title: GestureDetector(
            onTap: () {
              _controller.reload(); // Refresh WebView
            },
            child: Text(
              _pageTitle,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.copy, color: Colors.white),
              tooltip: "Copy URL",
              onPressed: _copyUrlToClipboard,
            ),
          ],
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
```

---

## ✅ Step 7: Connect Your Android Device

1. Connect your Android phone via USB
2. Enable **Developer Options > USB Debugging**
3. Run this to check if your phone is connected:

```bash
flutter devices
```

If it's listed, run the app:

```bash
flutter run
```

🎉 Your WebView app will now launch on your phone!

---

## ✅ Final Tips

- You can change the URL in `loadRequest(Uri.parse(...))` to open any site
- Add a favicon using the `flutter_launcher_icons` package
- Always test on a real device for best performance
