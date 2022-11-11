
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{project_name}}/utils/search_highlight_text/views/search_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Search Highlight Text Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SearchView(),
      ),
    );
  }
}
