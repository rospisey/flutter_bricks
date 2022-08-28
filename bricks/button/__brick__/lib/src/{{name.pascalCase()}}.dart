import 'package:flutter/material.dart';

class {{#pascalCase}}{{name}}{{/pascalCase}} extends StatelessWidget {
  const {{#pascalCase}}{{name}}{{/pascalCase}}({Key? key}) : super(key: key);

  {{#routable}}
  static PageRoute route() {
    return MaterialPageRoute(builder: (context) => const {{#pascalCase}}{{name}}{{/pascalCase}}());
  }
  
  {{/routable}}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const SizedBox();
  }
}