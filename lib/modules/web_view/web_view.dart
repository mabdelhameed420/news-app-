import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  Web(this.url,{Key? key}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3wcaz'),
      ),
      body: WebView(
        initialUrl: url,
      ),
      
    );
  }
}
