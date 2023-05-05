import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list_app/models/list_item.dart';
import 'package:shopping_list_app/widgets/list_card.dart';

import '../test_util.dart';

void main() {
  group('ListCard', () {
    testWidgets('should render', (widgetTester) async {
      Widget testWidget = TestUtil.buildTestScaffold(
          ListCard(item: ListItem(title: "List item", isComplete: false)));
      await widgetTester.pumpWidget(testWidget);
      expect(find.byKey(const Key('list-card')), findsOneWidget);
      expect(find.text('List item'), findsOneWidget);
      expect(find.byKey(const Key('list-card-item-toggle')), findsOneWidget);
      expect(find.byKey(const Key('list-card-item-button-increase')),
          findsOneWidget);
      expect(find.byKey(const Key('list-card-item-button-decrease')),
          findsOneWidget);
    });
  });
}
