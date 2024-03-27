import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/create_community_screen.dart';

void main() {
  testWidgets('Create Community Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CreateCommunityScreen()));

    // Add a delay to ensure all widgets are rendered
    await tester.pumpAndSettle();

    //find the community name text widget
    final communityNameText = find.byKey(const Key('community_name_text'));
    expect(communityNameText, findsOneWidget);

    //find the community name text box widget
    final communityNameTextBox = find.byKey(const Key('community_name_text_box'));
    expect(communityNameTextBox, findsOneWidget);

    //find the community type selector widget
    final communityTypeSelector = find.byKey(const Key('community_type_selector'));
    expect(communityTypeSelector, findsOneWidget);

    //find the age community text widget
    final ageCommunityText = find.byKey(const Key('age_community_text'));
    expect(ageCommunityText, findsOneWidget);

    //find the age switch widget
    final ageSwitch = find.byKey(const Key('age_switch'));
    expect(ageSwitch, findsOneWidget);

    //find the create community button widget
    final createCommunityButton = find.byKey(const Key('create_community_button'));
    expect(createCommunityButton, findsOneWidget);
  
  });
}
