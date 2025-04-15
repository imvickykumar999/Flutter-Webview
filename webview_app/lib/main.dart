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
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse("https://www.imvickykumar999.online/"));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Disable default back behavior
      onPopInvoked: (didPop) async {
        if (!didPop) {
          if (await _controller.canGoBack()) {
            _controller.goBack(); // Go back in WebView
          } else {
            Navigator.of(context).maybePop(); // Exit app if no back stack
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'imvickykumar999.online',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF04203F),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
