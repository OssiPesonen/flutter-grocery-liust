import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nanoid/nanoid.dart';
import 'package:shopping_list_app/models/list_item.dart';

class ItemsProvider extends ChangeNotifier {
  final Box<ListItem> _box;

  ItemsProvider(this._box);

  final List<ListItem> _items = [];
  final String itemsHiveBox = 'items-box';

  List<ListItem> get items {
    return [..._items];
  }

  /// Parse the item amount from the provided title
  /// if it is prefixed with a number
  ListItem _parseAmountFromTitle(ListItem item) {
    if (item.title.contains(' ')) {
      var split = item.title.split(' ');

      if (int.tryParse(split[0]) != null) {
        item.amount = int.parse(split[0]);
        split.removeAt(0);
        item.title = split.join(' ');
      }
    }

    return item;
  }

  /// Add item to list
  void addItem(ListItem item) {
    if (item.title.isEmpty) {
      return;
    }

    final targetId = nanoid(12);

    // Attempt to find an existing item from storage
    ListItem? existingItem = _box.get(item.id);

    if (existingItem != null) {
      // Create a new item to break reference
      ListItem newItem = ListItem(
        title: existingItem.title,
        id: existingItem.id,
        amount: 1,
        price: existingItem.price,
        isPickedUp: false,
        targetId: targetId,
      );

      _items.add(newItem);
    } else {
      item = _parseAmountFromTitle(item);

      List<ListItem> existing = _box.values
          .where((c) => c.title.toLowerCase() == item.title.toLowerCase())
          .toList();

      if (existing.isNotEmpty) {
        // Placeholder for the amount we might've just picked up from the title
        int amount = item.amount;

        // Create a new item to break reference
        ListItem newItem = ListItem(
          title: existing.first.title,
          id: existing.first.id,
          amount: amount,
          price: existing.first.price,
          isPickedUp: false,
          targetId: targetId,
        );

        _items.add(newItem);
      } else {
        item.targetId = targetId;

        // We didn't find anything matching
        _box.put(item.id, item);
        _items.add(item);
      }
    }

    notifyListeners();
  }

  /// Clear list of items
  void clearItems() {
    _items.removeWhere((element) => element.isPickedUp);
    notifyListeners();
  }

  /// Toggle item picked / not picked
  void toggleItemPicked(String targetId) {
    var index = _items.indexWhere((element) => element.targetId == targetId);

    if (index > -1) {
      _items[index].isPickedUp = !_items[index].isPickedUp;
      notifyListeners();
    }
  }

  /// Increase item amount needed to be picked up
  void increaseAmount(String targetId) {
    var index = _items.indexWhere((element) => element.targetId == targetId);

    if (index > -1) {
      _items[index].amount++;
      notifyListeners();
    }
  }

  /// Decrease item amount needed to be picked up
  void decreaseAmount(String targetId) {
    var index = _items.indexWhere((element) => element.targetId == targetId);

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

  /// Edit one item
  void editItem(ListItem item) {
    var index =
        _items.indexWhere((element) => element.targetId == item.targetId);

    if (index > -1) {
      _items[index] = item;
      notifyListeners();
    }
  }

  /// Change item's name
  void editItemName(String targetId, String title) {
    var index = _items.indexWhere((element) => element.targetId == targetId);

    if (index > -1) {
      _items[index].title = title;
      notifyListeners();
    }
  }

  /// Change item amount directly
  void editItemAmount(String targetId, int amount) {
    var index = _items.indexWhere((element) => element.targetId == targetId);

    if (index > -1) {
      _items[index].amount = amount;
      notifyListeners();
    }
  }

  /// Change item price
  void editItemPrice(String targetId, double price) {
    var index = _items.indexWhere((element) => element.targetId == targetId);

    if (index > -1) {
      _items[index].price = price;
      notifyListeners();
    }
  }

  List<ListItem> getItems(String titlePattern) {
    return _box.values
        .where(
            (c) => c.title.toLowerCase().contains(titlePattern.toLowerCase()))
        .toList();
  }
}
