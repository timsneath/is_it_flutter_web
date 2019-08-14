import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:demo_widget/master.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Is is Flutter web?',
        home: DefaultTabController(
          length: _tabs.length,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Is it Flutter web?'),
              bottom: TabBar(
                tabs: _tabs,
              ),
            ),
            body: TabBarView(
              children: [
                FlipViewMasterWidget(),
                const WebView(
                  initialUrl: 'https://timsneath.github.io/flutter_flip_view/',
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              ],
            ),
          ),
        ),
      );

  final _tabs = const <Tab>[
    Tab(text: 'Native'),
    Tab(text: 'Web'),
  ];
}
