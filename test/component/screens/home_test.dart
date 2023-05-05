import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shopping_list_app/screens/home.dart';

import '../test_util.dart';

void main() {
  group('Home', () {
    Widget testWidget = TestUtil.buildTestScaffold(const Home());

    testWidgets('should render', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(testWidget);
      expect(find.byKey(const Key('home-appbar')), findsOneWidget);
      expect(find.byKey(const Key('home-body')), findsOneWidget);
      expect(find.byKey(const Key('home-bottom-navigation')), findsOneWidget);
    });

    testWidgets('should add items to list', (widgetTester) async {
      await widgetTester.pumpWidget(testWidget);

      Key appBarTextFieldKey = const Key('home-appbar-textfield');

      expect(find.byKey(appBarTextFieldKey), findsOneWidget);

      String inputValue = 'List item';
      await widgetTester.enterText(find.byKey(appBarTextFieldKey), inputValue);
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);

      await widgetTester.pump();

      expect(find.text(inputValue), findsOneWidget);
    });

    testWidgets('should clear items when pressing clear', (widgetTester) async {
      await widgetTester.pumpWidget(testWidget);

      String inputValue = 'List item';
      await widgetTester.enterText(find.byKey(const Key('home-appbar-textfield')), inputValue);
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);

      await widgetTester.pump();

      expect(find.text(inputValue), findsOneWidget);

      await widgetTester.tap(find.byKey(const Key('home-bottom-navigation-button-clear-list')));
      await widgetTester.pumpAndSettle();

      expect(find.text('List item'), findsNothing);
    });
  });
}
