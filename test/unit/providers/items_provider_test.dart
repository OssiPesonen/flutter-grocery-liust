import 'package:flutter_test/flutter_test.dart';
import 'package:nanoid/nanoid.dart';
import 'package:shopping_list_app/models/list_item.dart';
import 'package:shopping_list_app/providers/items_provider.dart';

void main() {
  group('ItemsProvider', () {
    final itemsProvider = ItemsProvider();

    test('should return an empty list', () {
      expect(itemsProvider.items.length, 0);
    });

    test('should return an item once it is added', () {
      var id = nanoid();
      itemsProvider.addItem(ListItem(id: id, title: 'List item', isPickedUp: false, amount: 1));
      expect(itemsProvider.items.length, 1);
      expect(itemsProvider.items[0].id, id);
      expect(itemsProvider.items[0].isPickedUp, false);
      expect(itemsProvider.items[0].title, 'List item');
      expect(itemsProvider.items[0].amount, 1);
    });

    test('should clear items', () {
      itemsProvider.clearItems();
      expect(itemsProvider.items.length, 0);
    });

    test('should increase amount', () {
      var id = nanoid();
      itemsProvider.addItem(ListItem(id: id, title: 'List item', isPickedUp: false, amount: 1));
      itemsProvider.increaseAmount(id);
      expect(itemsProvider.items[0].amount, 2);
      itemsProvider.increaseAmount(id);
      expect(itemsProvider.items[0].amount, 3);
      itemsProvider.clearItems();
    });

    test('should decrease amount and remove item from list', () {
      var id = nanoid();
      itemsProvider.addItem(ListItem(id: id, title: 'List item', isPickedUp: false, amount: 3));

      itemsProvider.decreaseAmount(id);
      expect(itemsProvider.items[0].amount, 2);

      itemsProvider.decreaseAmount(id);
      expect(itemsProvider.items[0].amount, 1);

      itemsProvider.decreaseAmount(id);

      // Item should now disappear from the list
      expect(itemsProvider.items.length, 0);
    });

    test('should set amount if name starts with number and space', () {
      var id = nanoid();
      itemsProvider.addItem(ListItem(id: id, title: '20 List item', isPickedUp: false, amount: 1));
      expect(itemsProvider.items.length, 1);
      expect(itemsProvider.items[0].id, id);
      expect(itemsProvider.items[0].isPickedUp, false);
      expect(itemsProvider.items[0].title, 'List item');
      expect(itemsProvider.items[0].amount, 20);
    });
  });
}
