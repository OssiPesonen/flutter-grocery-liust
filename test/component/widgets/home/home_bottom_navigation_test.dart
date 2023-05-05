import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list_app/widgets/home/home_bottom_navigation.dart';

void main() {
  group('BottomNavigation', () {
    testWidgets('should render', (widgetTester) async {
      Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            bottomNavigationBar: HomeBottomNavigation(),
          ),
        ),
      );

      await widgetTester.pumpWidget(testWidget);

      expect(find.byKey(const Key('home-bottom-navigation')), findsOneWidget);

      expect(find.byKey(const Key('home-bottom-navigation-button-clear-list')),
          findsOneWidget);
    });
  });
}
