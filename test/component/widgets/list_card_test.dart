import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nanoid/nanoid.dart';
import 'package:flutter_test/flutter_test.dart';
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
            price: 9.90
          ),
        ),
      );

      await widgetTester.pumpWidget(testWidget);

      expect(find.byType(Dismissible), findsOneWidget);
      expect(find.text('List item'), findsOneWidget);
      expect(find.byType(Checkbox), findsOneWidget);
      expect(find.text("\$9.90"), findsOneWidget);

      expect(find.byIcon(Icons.remove_circle_outline_rounded), findsOneWidget);

      final amount = find.byKey(const Key('list-card-item-amount'));

      final text = widgetTester.firstWidget<Text>(amount);
      expect(text.data, '1');

      expect(find.byKey(const Key('list-card-item-button-increase')),
          findsOneWidget);

      expect(find.byKey(const Key('list-card-item-button-decrease')),
          findsOneWidget);
    });
  });
}
