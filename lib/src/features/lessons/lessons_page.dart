import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LessonsPage extends StatelessWidget {
  const LessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://seerah.kz/webview'));
    return  SafeArea(child: WebViewWidget(controller: controller));
  }
}
