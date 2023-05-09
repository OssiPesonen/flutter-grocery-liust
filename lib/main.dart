import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/models/list_item.dart';
import 'package:shopping_list_app/providers/items_provider.dart';
import 'package:shopping_list_app/screens/home.dart';

Future<void> main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<ListItem>(ListItemAdapter());
  Box<ListItem> box = await Hive.openBox<ListItem>('items-box');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemsProvider(box)),
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue),
      ),
      home: const Home(),
    );
  }
}
