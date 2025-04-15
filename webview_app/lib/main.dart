import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://www.imvickykumar999.online/")); // Replace with your site
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'imvickykumar999.online',
          style: TextStyle(color: Colors.white), // 👈 white text
        ),
        backgroundColor: const Color(0xFF04203F), // 👈 dark blue background
        iconTheme: const IconThemeData(color: Colors.white), // 👈 white icons (if any)
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
