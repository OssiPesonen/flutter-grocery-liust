import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nanoid/nanoid.dart';
import 'package:shopping_list_app/models/list_item.dart';

class ItemsProvider extends ChangeNotifier {
  final Box<ListItem> _searchBox;
  final Box<ListItem> _shoppingList;

  ItemsProvider(this._searchBox, this._shoppingList);

  List<ListItem> _items = [];
  final String storageBox = 'shopping-list';
  bool isInitialized = false;

  List<ListItem> get items {
    return [..._items];
  }

  /// Load items from box to provider when initialized
  void loadItems() {
    if (!isInitialized) {
      _items = _shoppingList.values.toList();
      isInitialized = true;
    }
  }

  /// When-ever items change, this should be called
  /// to persist data over app closing down
  void _persistItemsToStorage() {
    _shoppingList.clear();

    for (var i = 0; i < _items.length; i++) {
      _shoppingList.add(_items[i]);
    }
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

  /// Private method to persist items and notify listeners
  void _notifyListeners() {
    _persistItemsToStorage();
    notifyListeners();
  }

  /// Add item to list
  void addItem(ListItem item) {
    if (item.title.isEmpty) {
      return;
    }

    final targetId = nanoid(12);

    // Attempt to find an existing item from storage
    ListItem? existingItem = _searchBox.get(item.id);

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

      List<ListItem> existing = _searchBox.values
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
        _searchBox.put(item.id, item);
        _items.add(item);
      }
    }

    _notifyListeners();
  }

  /// Clear list of items
  void clearItems() {
    _items.removeWhere((element) => element.isPickedUp);
    _notifyListeners();
  }

  /// Toggle item picked / not picked
  void toggleItemPicked(String targetId) {
    var index = _items.indexWhere((element) => element.targetId == targetId);

    if (index > -1) {
      _items[index].isPickedUp = !_items[index].isPickedUp;
      _notifyListeners();
    }
  }

  /// Increase item amount needed to be picked up
  void increaseAmount(String targetId) {
    var index = _items.indexWhere((element) => element.targetId == targetId);

    if (index > -1) {
      _items[index].amount++;
      _notifyListeners();
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

      _notifyListeners();
    }
  }

  /// Edit one item
  void editItem(ListItem item) {
    var existingItem = _searchBox.get(item.id);

    // Only update storage if title has remained the same
    final bool updateStorage =
        existingItem != null && existingItem.title == item.title;

    if (!updateStorage) {
      // Simply update the list item, not storage
      var index =
          _items.indexWhere((element) => element.targetId == item.targetId);

      if (index > -1) {
        _items[index] = item;
        _notifyListeners();
      }
    } else {
      // Update all list items with same id but don't touch targetId
      _items = _items.map((e) {
        if (e.id == item.id && e.title == item.title) {
          e.price = item.price;
          e.title = item.title;
          e.amount = item.amount;
        }

        return e;
      }).toList();

      existingItem.price = item.price;
      existingItem.title = item.title;
      existingItem.amount = item.amount;
      _searchBox.put(item.id, item);
      _notifyListeners();
    }
  }

  /// Change item's name on the shopping list
  /// Do not persist changes
  void editItemName(String targetId, String title) {
    var index = _items.indexWhere((element) => element.targetId == targetId);

    if (index > -1) {
      _items[index].title = title;
      _notifyListeners();
    }
  }

  /// Change item amount in shopping list
  void editItemAmount(String targetId, int amount) {
    var index = _items.indexWhere((element) => element.targetId == targetId);

    if (index > -1) {
      _items[index].amount = amount;
      _notifyListeners();
    }
  }

  /// Change item price
  void editItemPrice(String id, double price) {
    // Edit the price of all matching items on the shopping list
    _items = _items.map((e) {
      if (e.id == id) {
        e.price = price;
      }

      return e;
    }).toList();

    var item = _searchBox.get(id);

    if (item != null) {
      item.price = price;
      _searchBox.put(id, item);
    }

    _notifyListeners();
  }

  /// Return list of persisted items by given pattern (ie. filter search)
  List<ListItem> getSavedItems(String titlePattern) {
    return _searchBox.values
        .where(
            (c) => c.title.toLowerCase().contains(titlePattern.toLowerCase()))
        .toList();
  }
}
