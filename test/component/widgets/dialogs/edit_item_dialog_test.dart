import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list_app/models/list_item.dart';
import 'package:shopping_list_app/widgets/dialogs/edit_item_dialog.dart';

import '../../test_util.dart';

void main() {
  group('EditItemDialog', () {
    testWidgets('should render', (widgetTester) async {
      Widget testWidget = TestUtil.buildTestScaffold(
        EditItemDialog(
          item: ListItem(
              id: 'abc', title: 'List item', isPickedUp: false, amount: 3),
        ),
      );

      await widgetTester.pumpWidget(testWidget);
      
      expect(find.text('List item'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      expect(find.text('Price'), findsNWidgets(2));
    });
  });
}
