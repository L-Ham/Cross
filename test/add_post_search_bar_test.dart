import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/add_post_components/add_post_search_bar.dart';

void main() {
  testWidgets('AddPostSearchBar UI test', (WidgetTester tester) async {
    // Build the AddPostSearchBar widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AddPostSearchBar(
            isSearchFocused: FocusNode(),
            searchController: TextEditingController(),
          ),
        ),
      ),
    );
    await tester.pump();

    // Verify that the search bar is displayed
    expect(find.byType(TextField), findsOneWidget);

    // Verify that the search bar has the correct decoration
    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.decoration?.hintText, 'Search for a community');
    expect(textField.decoration?.prefixIcon, isNotNull);
    expect(textField.decoration?.suffixIcon, isNull);

    // Enter text in the search bar
    await tester.enterText(find.byType(TextField), 'test');
    await tester.pumpAndSettle();

    // // Verify that the cancel button is displayed
    // expect(find.byKey(const Key('cancel_button')), findsOneWidget);

    // // Tap the cancel button
    // await tester.tap(find.byKey(const Key('cancel_button')));
    // await tester.pumpAndSettle();

    // // Verify that the search bar is cleared
    // expect(find.text('test'), findsNothing);
  });
}
