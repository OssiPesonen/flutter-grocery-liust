import 'package:flutter/cupertino.dart';

class ItemsProvider extends ChangeNotifier {
  final List<String> _items = [];

  List<String> get items {
    return [..._items];
  }

  void addItem(String title) {
    _items.add(title);
    notifyListeners();
  }

  void clearItems() {
    _items.clear();
    notifyListeners();
  }
}