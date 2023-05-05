import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list_app/models/list_item.dart';
import 'package:shopping_list_app/providers/items_provider.dart';

void main() {
  group('ItemsProvider', () {
    final itemsProvider = ItemsProvider();

    test('should return an empty list', () {
      expect(itemsProvider.items.length, 0);
    });

    test('should return an item once it is added', () {
      itemsProvider.addItem(ListItem(title: 'List item', isComplete: false));
      expect(itemsProvider.items.length, 1);
    });

    test('should clear items', () {
      itemsProvider.clearItems();
      expect(itemsProvider.items.length, 0);
    });
  });
}
