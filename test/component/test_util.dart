import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_list_app/models/list_item.dart';
import 'package:shopping_list_app/providers/items_provider.dart';
import 'package:provider/provider.dart';
import '../mocks/box.mocks.dart';

class TestUtil {
  static Box<ListItem> mockBox() {
    Box<ListItem> box = MockBox();
    when(box.get(any)).thenReturn(null);
    when(box.values).thenReturn([]);
    when(box.put);
    when((box as MockBox).add(any)).thenAnswer((_) => Future(() => 1));
    when(box.clear()).thenAnswer((_) => Future(() => 1));
    return box;
  }

  static Widget buildTestScaffold(Widget component) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemsProvider(mockBox(), mockBox())),
      ],
      child: Builder(
        builder: (_) => MaterialApp(home: Scaffold(body: component)),
      ),
    );
  }
}
