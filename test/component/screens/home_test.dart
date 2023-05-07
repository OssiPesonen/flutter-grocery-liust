import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'package:shopping_list_app/screens/home.dart';
import 'package:shopping_list_app/widgets/list_card.dart';

import '../test_util.dart';

void main() {
  group('Home', () {
    Widget testWidget = TestUtil.buildTestScaffold(const Home());
    Intl.defaultLocale = 'en_US';

    testWidgets('should render', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(testWidget);
      expect(find.byKey(const Key('home-appbar')), findsOneWidget);
      expect(find.byKey(const Key('bottom-navigation')), findsOneWidget);
      expect(find.text('Start by adding an item to your shopping list!'), findsOneWidget);
    });

    testWidgets('should add items to list', (widgetTester) async {
      await widgetTester.pumpWidget(testWidget);

      Key appBarTextFieldKey = const Key('appbar-textfield');

      expect(find.byKey(appBarTextFieldKey), findsOneWidget);

      String inputValue = 'List item';
      await widgetTester.enterText(find.byKey(appBarTextFieldKey), inputValue);
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);

      await widgetTester.pump();

      expect(find.byKey(const Key('home-body')), findsOneWidget);
      expect(find.text(inputValue), findsOneWidget);
    });

    testWidgets('should not clear not picked up items when pressing clear', (widgetTester) async {
      await widgetTester.pumpWidget(testWidget);

      String inputValue = 'List item';
      await widgetTester.enterText(find.byKey(const Key('appbar-textfield')), inputValue);
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);

      await widgetTester.pump();

      expect(find.text(inputValue), findsOneWidget);

      await widgetTester.tap(find.byKey(const Key('bottom-navigation-button-clear-list')));
      await widgetTester.pumpAndSettle();

      expect(find.text('List item'), findsOneWidget);
    });

    testWidgets('should clear picked up items when pressing clear', (widgetTester) async {
      await widgetTester.pumpWidget(testWidget);

      String inputValue = 'List item';
      await widgetTester.enterText(find.byKey(const Key('appbar-textfield')), inputValue);
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);
      await widgetTester.pump();

      String inputValue2 = 'List item 2';
      await widgetTester.enterText(find.byKey(const Key('appbar-textfield')), inputValue2);
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);
      await widgetTester.pump();

      expect(find.text(inputValue), findsOneWidget);
      expect(find.text(inputValue2), findsOneWidget);

      await widgetTester.drag(find.byType(ListCard).first, const Offset(500.0, 0.0));
      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.byKey(const Key('bottom-navigation-button-clear-list')));
      await widgetTester.pumpAndSettle();

      expect(find.text('List item 2'), findsOneWidget);
    });

    testWidgets('should toggle check on item checkbox press', (widgetTester) async {
      await widgetTester.pumpWidget(testWidget);

      String inputValue = 'List item';
      await widgetTester.enterText(find.byKey(const Key('appbar-textfield')), inputValue);
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);

      await widgetTester.pump();

      await widgetTester.tap(find.byType(Checkbox));
      await widgetTester.pumpAndSettle();

      expect(widgetTester.widget<Checkbox>(find.byType(Checkbox)).value, true);
      expect(find.text('Picked up items'), findsOneWidget);
    });


    testWidgets('should toggle check on item swipe right', (widgetTester) async {
      await widgetTester.pumpWidget(testWidget);

      String inputValue = 'List item';
      await widgetTester.enterText(find.byKey(const Key('appbar-textfield')), inputValue);
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);

      await widgetTester.pump();

      await widgetTester.drag(find.byType(ListCard), const Offset(500.0, 0.0));
      await widgetTester.pumpAndSettle();

      expect(widgetTester.widget<Checkbox>(find.byType(Checkbox)).value, true);
      expect(find.text('Picked up items'), findsOneWidget);
    });

    testWidgets('should show edit dialog on swipe left', (widgetTester) async {
      await widgetTester.pumpWidget(testWidget);

      String inputValue = 'List item';
      await widgetTester.enterText(find.byKey(const Key('appbar-textfield')), inputValue);
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);

      await widgetTester.pump();

      await widgetTester.drag(find.byType(ListCard), const Offset(-500.0, 0.0));
      await widgetTester.pumpAndSettle();

      expect(find.byKey(const Key('edit-item-dialog')), findsOneWidget);
    });

    testWidgets('should change item price when inputting it in dialog', (widgetTester) async {
      await widgetTester.pumpWidget(testWidget);

      String inputValue = 'List item';
      await widgetTester.enterText(find.byKey(const Key('appbar-textfield')), inputValue);
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);

      await widgetTester.pump();

      // Open the dialog
      await widgetTester.drag(find.byType(ListCard), const Offset(-500.0, 0.0));
      await widgetTester.pumpAndSettle();
      expect(find.byKey(const Key('edit-item-dialog')), findsOneWidget);

      // Input price
      await widgetTester.enterText(find.byKey(const Key('edit-item-dialog-price')), '9.90');
      await widgetTester.pump();
      expect(find.text('9.90'), findsOneWidget);

      await widgetTester.tap(find.byKey(const Key('edit-item-dialog-save')));
      await widgetTester.pumpAndSettle();

      expect(find.text('\$9.90'), findsOneWidget);
    });
  });
}
