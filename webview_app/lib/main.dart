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
            if (uri.host.contains('imvickykumar999.online')) {
              return NavigationDecision.navigate;
            } else {
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
              return NavigationDecision.prevent;
            }
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
        ),
      )
      ..loadRequest(Uri.parse("https://www.imvickykumar999.online/"));
  }

  void _copyUrlToClipboard() {
    Clipboard.setData(ClipboardData(text: _currentUrl)).then((_) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("URL copied to clipboard")));
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
              _controller.reload(); // Refresh the WebView
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
