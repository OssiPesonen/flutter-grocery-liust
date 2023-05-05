import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list_app/widgets/list_card.dart';

import '../test_util.dart';

void main() {
  group('ListCard', () {
    testWidgets('should render', (widgetTester) async {
      Widget testWidget = TestUtil.buildTestScaffold(ListCard(title: "List item"));
      await widgetTester.pumpWidget(testWidget);
      expect(find.text('List item'), findsOneWidget);
    });
  });
}
