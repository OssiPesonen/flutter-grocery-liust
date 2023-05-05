import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/list_item.dart';

class ItemsProvider extends ChangeNotifier {
  final List<ListItem> _items = [];

  List<ListItem> get items {
    return [..._items];
  }

  void addItem(ListItem item) {
    _items.add(item);
    notifyListeners();
  }

  void clearItems() {
    _items.clear();
    notifyListeners();
  }

  void toggleItem(String title) {
    var index = items.indexWhere((element) => element.title == title);
    items[index].isComplete = !items[index].isComplete;
    notifyListeners();
  }
}