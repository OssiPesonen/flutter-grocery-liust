import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list_app/widgets/add_item_input.dart';

import '../test_util.dart';

void main() {
  group('AppBar', () {
    testWidgets('should render', (widgetTester) async {
      Widget testWidget = TestUtil.buildTestScaffold(const AddItemInput());
      await widgetTester.pumpWidget(testWidget);
      expect(find.byKey(const Key('appbar-textfield')), findsOneWidget);
    });
  });
}