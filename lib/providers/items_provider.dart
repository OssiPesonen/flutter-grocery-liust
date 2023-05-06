import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/list_item.dart';

class ItemsProvider extends ChangeNotifier {
  final List<ListItem> _items = [];

  List<ListItem> get items {
    return [..._items];
  }

  /// Add item to list
  void addItem(ListItem item) {
    // If title starts with number, followed by a space, use number
    // as the amount and rest as the title
    if (item.title.contains(' ')) {
      var split = item.title.split(' ');

      if (int.tryParse(split[0]) != null) {
        item.amount = int.parse(split[0]);
        split.removeAt(0);
        item.title = split.join(' ');
      }
    }
    
    _items.add(item);
    notifyListeners();
  }

  /// Clear list of items
  void clearItems() {
    _items.clear();
    notifyListeners();
  }

  /// Toggle item picked / not picked
  void toggleItemPicked(String id) {
    var index = _items.indexWhere((element) => element.id == id);

    if (index > -1) {
      _items[index].isPickedUp = !_items[index].isPickedUp;
      notifyListeners();
    }
  }

  /// Increase item amount needed to be picked up
  void increaseAmount(String id) {
    var index = _items.indexWhere((element) => element.id == id);

    if (index > -1) {
      _items[index].amount++;
      notifyListeners();
    }
  }

  /// Decrease item amount needed to be picked up
  void decreaseAmount(String id) {
    var index = _items.indexWhere((element) => element.id == id);

    if (index > -1) {
      if (items[index].amount > 0) {
        _items[index].amount--;
      }

      if (items[index].amount == 0) {
        _items.removeAt(index);
      }

      notifyListeners();
    }
  }
}