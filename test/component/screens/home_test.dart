import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shopping_list_app/screens/home.dart';
import 'package:shopping_list_app/widgets/list_card.dart';

import '../test_util.dart';

void main() {
  group('Home', () {
    Widget testWidget = TestUtil.buildTestScaffold(const Home());

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

    testWidgets('should clear items when pressing clear', (widgetTester) async {
      await widgetTester.pumpWidget(testWidget);

      String inputValue = 'List item';
      await widgetTester.enterText(find.byKey(const Key('appbar-textfield')), inputValue);
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);

      await widgetTester.pump();

      expect(find.text(inputValue), findsOneWidget);

      await widgetTester.tap(find.byKey(const Key('bottom-navigation-button-clear-list')));
      await widgetTester.pumpAndSettle();

      expect(find.text('List item'), findsNothing);
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


    testWidgets('should toggle check on item swipe', (widgetTester) async {
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
  });
}
