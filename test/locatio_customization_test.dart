import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/screens/location_customization.dart';
import '../lib/countries.dart';

void main() {
  testWidgets('Location Customization screen UI test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: LocationCustomization(initialValue: 'Egypt')));

    for (String country in countries)
      expect(find.text(country), findsOneWidget);
  });
}
