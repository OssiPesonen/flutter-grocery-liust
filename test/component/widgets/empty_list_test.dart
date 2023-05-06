import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list_app/widgets/empty_list.dart';

import '../test_util.dart';

void main() {
  group('EmptyList', () {
    testWidgets('should render', (widgetTester) async {
      Widget testWidget = TestUtil.buildTestScaffold(const EmptyList());
      await widgetTester.pumpWidget(testWidget);
      expect(find.byIcon(Icons.cake_outlined), findsOneWidget);
      expect(find.text('Start by adding an item to your shopping list!'),
          findsOneWidget);
    });
  });
}
