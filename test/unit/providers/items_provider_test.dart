import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:nanoid/nanoid.dart';
import 'package:shopping_list_app/models/list_item.dart';
import 'package:shopping_list_app/providers/items_provider.dart';

import '../../mocks/box.mocks.dart';

void main() {
  Box<ListItem> mockBox() {
    Box<ListItem> box = MockBox();
    when(box.get(any)).thenReturn(null);
    when(box.values).thenReturn([]);
    when(box.put);
    when((box as MockBox).add(any)).thenAnswer((_) => Future(() => 1));
    when(box.clear()).thenAnswer((_) => Future(() => 1));
    return box;
  }
  
  group('ItemsProvider', () {
    test('should return an empty list', () {
      final itemsProvider = ItemsProvider(mockBox(), mockBox());
      expect(itemsProvider.items.length, 0);
    });

    test('should return an item once it is added', () {
      final itemsProvider = ItemsProvider(mockBox(), mockBox());
      var id = nanoid();
      itemsProvider.addItem(ListItem(id: id, title: 'List item', isPickedUp: false, amount: 1));
      expect(itemsProvider.items.length, 1);
      expect(itemsProvider.items[0].id, id);
      expect(itemsProvider.items[0].isPickedUp, false);
      expect(itemsProvider.items[0].title, 'List item');
      expect(itemsProvider.items[0].amount, 1);
    });

    test('should return an existing item based on ID', () {
      var id = nanoid();
      var existingId = nanoid();

      final box = mockBox();
      when(box.get(id)).thenReturn(ListItem(id: existingId, title: 'Existing list item', isPickedUp: false, amount: 1));

      final itemsProvider = ItemsProvider(box, mockBox());
      itemsProvider.addItem(ListItem(id: id, title: 'List item', isPickedUp: false, amount: 1));

      expect(itemsProvider.items.length, 1);
      expect(itemsProvider.items[0].id, existingId);
      expect(itemsProvider.items[0].isPickedUp, false);
      expect(itemsProvider.items[0].title, 'Existing list item');
      expect(itemsProvider.items[0].amount, 1);
    });

    test('should return an existing item based on title', () {
      var id = nanoid();
      var existingId = nanoid();

      final box = mockBox();
      when(box.values).thenReturn([ListItem(id: existingId, title: 'List item', isPickedUp: false, amount: 1)]);

      final itemsProvider = ItemsProvider(box, mockBox());
      itemsProvider.addItem(ListItem(id: id, title: '20 List item', isPickedUp: false, amount: 1));

      expect(itemsProvider.items.length, 1);
      expect(itemsProvider.items[0].id, existingId);
      expect(itemsProvider.items[0].isPickedUp, false);
      expect(itemsProvider.items[0].title, 'List item');
      expect(itemsProvider.items[0].amount, 20);
    });

    test('should clear items', () {
      final itemsProvider = ItemsProvider(mockBox(), mockBox());
      itemsProvider.clearItems();
      expect(itemsProvider.items.length, 0);
    });

    test('should increase amount', () {
      final itemsProvider = ItemsProvider(mockBox(), mockBox());
      var id = nanoid();
      itemsProvider.addItem(ListItem(id: id, title: 'List item', isPickedUp: false, amount: 1));
      final targetId = itemsProvider.items[0].targetId!;
      itemsProvider.increaseAmount(targetId);
      expect(itemsProvider.items[0].amount, 2);
      itemsProvider.increaseAmount(targetId);
      expect(itemsProvider.items[0].amount, 3);
      itemsProvider.clearItems();
    });

    test('should decrease amount and remove item from list', () {
      final itemsProvider = ItemsProvider(mockBox(), mockBox());
      var id = nanoid();
      itemsProvider.addItem(ListItem(id: id, title: 'List item', isPickedUp: false, amount: 3));

      final targetId = itemsProvider.items[0].targetId!;
      itemsProvider.decreaseAmount(targetId);
      expect(itemsProvider.items[0].amount, 2);

      itemsProvider.decreaseAmount(targetId);
      expect(itemsProvider.items[0].amount, 1);

      itemsProvider.decreaseAmount(targetId);

      // Item should now disappear from the list
      expect(itemsProvider.items.length, 0);
    });

    test('should set amount if name starts with number and space', () {
      final itemsProvider = ItemsProvider(mockBox(), mockBox());
      var id = nanoid();
      itemsProvider.addItem(ListItem(id: id, title: '20 List item', isPickedUp: false, amount: 1));
      expect(itemsProvider.items.length, 1);
      expect(itemsProvider.items[0].id, id);
      expect(itemsProvider.items[0].isPickedUp, false);
      expect(itemsProvider.items[0].title, 'List item');
      expect(itemsProvider.items[0].amount, 20);
    });

    test('should edit item title', () {
      final itemsProvider = ItemsProvider(mockBox(), mockBox());
      var id = nanoid();
      itemsProvider.addItem(ListItem(id: id, title: 'List item', isPickedUp: false, amount: 1));
      final targetId = itemsProvider.items[0].targetId!;
      itemsProvider.editItemName(targetId, 'List item 1');
      expect(itemsProvider.items[0].title, 'List item 1');
    });

    test('should edit the item', () {
      final box = mockBox();
      final itemsProvider = ItemsProvider(box, mockBox());

      var id = nanoid();
      final listItem = ListItem(id: id, title: 'List item', isPickedUp: false, amount: 1);
      itemsProvider.addItem(listItem);

      expect(itemsProvider.items.length, 1);
      expect(itemsProvider.items[0].id, id);
      expect(itemsProvider.items[0].isPickedUp, false);
      expect(itemsProvider.items[0].title, 'List item');
      expect(itemsProvider.items[0].amount, 1);

      listItem.title = 'List item 1';
      listItem.price = 10.0;
      listItem.isPickedUp = true;
      itemsProvider.editItem(listItem);

      expect(itemsProvider.items.length, 1);
      expect(itemsProvider.items[0].id, id);
      expect(itemsProvider.items[0].isPickedUp, true);
      expect(itemsProvider.items[0].title, 'List item 1');
      expect(itemsProvider.items[0].price, 10.0);

      // Called twice because a call to addItem makes one call here
      verify((box as MockBox).get(any)).called(2);

      // Should've been called once because of a call to addItem
      verify((box as MockBox).put(any, any)).called(1);
    });

    test('should edit the item and persist changes', () {
      final box = mockBox();
      final itemsProvider = ItemsProvider(box, mockBox());
      var id = nanoid();
      final listItem = ListItem(id: id, title: 'List item', isPickedUp: false, amount: 1);

      itemsProvider.addItem(listItem);

      expect(itemsProvider.items.length, 1);
      expect(itemsProvider.items[0].id, id);
      expect(itemsProvider.items[0].isPickedUp, false);
      expect(itemsProvider.items[0].title, 'List item');
      expect(itemsProvider.items[0].amount, 1);

      listItem.title = 'List item';
      listItem.price = 15.0;
      listItem.amount = 10;

      when(box.get(id)).thenReturn(itemsProvider.items[0]);
      itemsProvider.editItem(listItem);

      expect(itemsProvider.items.length, 1);
      expect(itemsProvider.items[0].id, id);
      expect(itemsProvider.items[0].isPickedUp, false);
      expect(itemsProvider.items[0].title, 'List item');
      expect(itemsProvider.items[0].price, 15.0);
      expect(itemsProvider.items[0].amount, 10);

      // Called twice because a call to addItem makes one call here
      verify((box as MockBox).get(any)).called(2);
      // Should've been called once because of a call to addItem
      verify((box as MockBox).put(id, itemsProvider.items[0])).called(2);
    });

    test('should change the amount', () {
      final itemsProvider = ItemsProvider(mockBox(), mockBox());
      var id = nanoid();
      itemsProvider.addItem(ListItem(id: id, title: 'List item', isPickedUp: false, amount: 1));
      final targetId = itemsProvider.items[0].targetId!;
      itemsProvider.editItemAmount(targetId, 3);
      expect(itemsProvider.items[0].amount, 3);
    });

    test('should edit item price', () {
      final itemsProvider = ItemsProvider(mockBox(), mockBox());
      var id = nanoid();
      itemsProvider.addItem(ListItem(id: id, title: 'List item', isPickedUp: false, amount: 1, price: 10.0));
      expect(itemsProvider.items[0].price, 10.0);
      itemsProvider.editItemPrice(id, 5.0);
      expect(itemsProvider.items[0].price, 5.0);
    });

    test('should return a list of items from hive', () {
      final box = mockBox();
      when(box.values).thenReturn([
        ListItem(id: nanoid(), title: 'List item', isPickedUp: false, amount: 1, price: 10.0),
        ListItem(id: nanoid(), title: 'List item 2', isPickedUp: true, amount: 2, price: 5.0)
      ]);
      final itemsProvider = ItemsProvider(box, mockBox());
      final items = itemsProvider.getSavedItems('List item');
      expect(items.length, 2);
    });

    test('should persist price in database if ID matches existing', () {
      final box = mockBox();
      final itemsProvider = ItemsProvider(box, mockBox());
      final id = nanoid();

      itemsProvider.addItem(ListItem(id: id, title: 'List item', isPickedUp: false, amount: 1, targetId: nanoid(), price: 10));
      itemsProvider.addItem(ListItem(id: id, title: 'List item 2', isPickedUp: false, amount: 1, targetId: nanoid(), price: 12));

      // Method should call get to attempt to find an existing item and modify it's price
      when(box.get(id)).thenReturn(ListItem(id: id, title: 'List item', isPickedUp: false, amount: 1, price: 10.0, targetId: nanoid()));

      // Call the method with a new price
      itemsProvider.editItemPrice(id, 15.00);

      // Includes the put() calls in addItem(), so 2 + 1
      verify((box as MockBox).put(id, any)).called(3);

      expect(itemsProvider.items[0].price, 15.0);
      expect(itemsProvider.items[1].price, 15.0);
    });
  });
}
