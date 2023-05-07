import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:nanoid/nanoid.dart';
import 'package:shopping_list_app/models/list_item.dart';
import 'package:shopping_list_app/widgets/list_card.dart';

import '../test_util.dart';

void main() {
  group('ListCard', () {
    testWidgets('should render', (widgetTester) async {
      var id = nanoid();
      Intl.defaultLocale = 'en_US';

      Widget testWidget = TestUtil.buildTestScaffold(
        ListCard(
          item: ListItem(
            id: id,
            title: "List item",
            isPickedUp: false,
            amount: 1,
            price: 9.90
          ),
        ),
      );

      await widgetTester.pumpWidget(testWidget);

      expect(find.byKey(Key('list-card-$id')), findsOneWidget);
      expect(find.text('List item'), findsOneWidget);
      expect(find.byKey(Key('list-card-item-toggle-$id')), findsOneWidget);
      expect(find.text("\$9.90"), findsOneWidget);

      expect(find.byKey(Key('list-card-item-button-increase-$id')),
          findsOneWidget);

      final amount = find.byKey(Key('list-card-item-amount-$id'));
      final text = widgetTester.firstWidget<Text>(amount);
      expect(text.data, '1');

      expect(find.byKey(Key('list-card-item-button-increase-$id')),
          findsOneWidget);

      expect(find.byKey(Key('list-card-item-button-decrease-$id')),
          findsOneWidget);
    });
  });
}
