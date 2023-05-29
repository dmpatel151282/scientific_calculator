import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scientific_calculator/utils/server.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ScientificCalculatorScreen extends StatefulWidget {
  const ScientificCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<ScientificCalculatorScreen> createState() =>
      _ScientificCalculatorScreenState();
}

class _ScientificCalculatorScreenState
    extends State<ScientificCalculatorScreen> {
  final Server _server = Server();
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _server.start();

    PlatformWebViewControllerCreationParams params =
        const PlatformWebViewControllerCreationParams();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..enableZoom(false)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            //debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            //debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            //debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            //debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            //debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(
          Uri.parse('http://localhost:12121/assets/html/calculator.html'));

    _controller = controller;
  }

  @override
  void dispose() {
    _server.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scientific Calculator"),
        centerTitle: true,
      ),
      body: bodySection(),
    );
  }

  Widget bodySection() {
    return SizedBox(
      height: 550.h,
      child: Center(
        child: WebViewWidget(
          controller: _controller,
        ),
      ),
    );
  }
}
