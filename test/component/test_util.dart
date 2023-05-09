import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_list_app/models/list_item.dart';
import 'package:shopping_list_app/providers/items_provider.dart';
import 'package:provider/provider.dart';
import '../mocks/box.mocks.dart';

class TestUtil {
  static Widget buildTestScaffold(Widget component) {
    Box<ListItem> box = MockBox();

    when(box.get(any)).thenReturn(null);
    when(box.values).thenReturn([]);
    when(box.put);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemsProvider(box)),
      ],
      child: Builder(
        builder: (_) => MaterialApp(home: Scaffold(body: component)),
      ),
    );
  }
}
