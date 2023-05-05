import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list_app/widgets/home/home_app_bar.dart';

import '../../test_util.dart';

void main() {
  group('AppBar', () {
    testWidgets('should render', (widgetTester) async {
      Widget testWidget = TestUtil.buildTestScaffold(const HomeAppBar());
      await widgetTester.pumpWidget(testWidget);
      expect(find.byKey(const Key('home-appbar-textfield')), findsOneWidget);
    });
  });
}