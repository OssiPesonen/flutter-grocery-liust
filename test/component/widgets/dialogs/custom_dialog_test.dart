import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list_app/widgets/dialogs/custom_dialog.dart';

import '../../test_util.dart';

void main() {
  group('CustomDialog', () {
    testWidgets('should render', (widgetTester) async {
      Widget testWidget = TestUtil.buildTestScaffold(
        CustomDialog(
          children: [
            Container(
              child: Text('Custom dialog'),
            )
          ],
        ),
      );

      await widgetTester.pumpWidget(testWidget);
      expect(find.text('Custom dialog'), findsOneWidget);
    });
  });
}
