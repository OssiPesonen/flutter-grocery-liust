import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nanoid/nanoid.dart';
import 'package:shopping_list_app/models/list_item.dart';
import 'package:shopping_list_app/widgets/item_list.dart';
import 'package:shopping_list_app/widgets/list_card.dart';

import '../test_util.dart';

void main() {
  group('ItemList', () {
    testWidgets('should render', (widgetTester) async {
      var id = nanoid();

      Widget testWidget = TestUtil.buildTestScaffold(ItemList(
        items: [
          ListItem(id: id, title: "List item", isPickedUp: false, amount: 1),
          ListItem(id: nanoid(), title: "List item 2", isPickedUp: false, amount: 1),
        ],
      ));

      await widgetTester.pumpWidget(testWidget);
      expect(find.byType(ListCard), findsNWidgets(2));
    });
  });
}
