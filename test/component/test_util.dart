import 'package:flutter/material.dart';
import 'package:shopping_list_app/providers/items_provider.dart';
import 'package:provider/provider.dart';

class TestUtil {
  static Widget buildTestScaffold(Widget component) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemsProvider()),
      ],
      child: Builder(
        builder: (_) => MaterialApp(home: Scaffold(body: component)),
      ),
    );
  }
}
