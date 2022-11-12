import 'package:flutter/material.dart';
import 'package:{{project_name}}/utils/responsive_layout/layout/responsive_flex.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Search Highlight Text Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AboutPage(),
      );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: ResponsiveFlex(mobileFlex: 0, desktopFlex: 1).getFlex(context),
            child: Container(
              color: Colors.red,
              child: Text("Red"),
            ),
          ),
          Expanded(
            flex: ResponsiveFlex(mobileFlex: 1, desktopFlex: 3).getFlex(context),
            child: Container(
              color: Colors.green,
              child: Text("Green"),
            ),
          )
        ],
      ),
    );
  }
}