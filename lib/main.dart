import 'package:flutter/material.dart';
import 'package:shopping_list_app/providers/items_provider.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/screens/home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      theme: ThemeData(),
      home: const Home(),
    );
  }
}
