import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list_app/widgets/number_input.dart';

import '../test_util.dart';

void main() {
  group('NumberInput', () {
    testWidgets('should render', (widgetTester) async {
      Widget testWidget = TestUtil.buildTestScaffold(NumberInput(
        amount: 3,
        decreaseCallback: () => null,
        increaseCallback: () => null,
      ));

      await widgetTester.pumpWidget(testWidget);
      expect(find.text('3'), findsOneWidget);
    });
  });
}
