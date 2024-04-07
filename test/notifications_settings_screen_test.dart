import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/screens/notifications_settings_screen.dart';

void main() {
  testWidgets('NotificationSettingsScreen displays all widgets with keys', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: NotificationSettingsScreen(),
      ),
    );
    
    // Verify that the NotificationSettingsScreen has all the necessary widgets displayed

    expect(find.byKey(const Key('notification_settings_app_bar')), findsOneWidget);
    expect(find.byKey(const Key('notification_settings_app_bar_title')), findsOneWidget);
    expect(find.byKey(const Key('messages_segment_title')), findsOneWidget);
    expect(find.byKey(const Key('private_messages_tile')), findsOneWidget);
    expect(find.byKey(const Key('private_messages_switch')), findsOneWidget);
    expect(find.byKey(const Key('chat_messages_tile')), findsOneWidget);
    expect(find.byKey(const Key('chat_messages_switch')), findsOneWidget);
    expect(find.byKey(const Key('chat_requests_tile')), findsOneWidget);
    expect(find.byKey(const Key('chat_requests_switch')), findsOneWidget);
    expect(find.byKey(const Key('activity_title')), findsOneWidget);
    expect(find.byKey(const Key('mentions_tile')), findsOneWidget);
    expect(find.byKey(const Key('mentions_switch')), findsOneWidget);
    expect(find.byKey(const Key('comments_on_your_posts_tile')), findsOneWidget);
    expect(find.byKey(const Key('comments_on_your_posts_switch')), findsOneWidget);
    expect(find.byKey(const Key('upvotes_on_your_posts_tile')), findsOneWidget);
    expect(find.byKey(const Key('upvotes_on_your_posts_switch')), findsOneWidget);
    expect(find.byKey(const Key('upvotes_on_your_comments_tile')), findsOneWidget);
    expect(find.byKey(const Key('upvotes_on_your_comments_switch')), findsOneWidget);
    expect(find.byKey(const Key('replies_to_your_comments_tile')), findsOneWidget);
    expect(find.byKey(const Key('replies_to_your_comments_switch')), findsOneWidget);
    expect(find.byKey(const Key('new_followers_tile')), findsOneWidget);
    expect(find.byKey(const Key('new_followers_switch')), findsOneWidget);
    expect(find.byKey(const Key('updates_title')), findsOneWidget);
    expect(find.byKey(const Key('cake_day_tile')), findsOneWidget);
    expect(find.byKey(const Key('cake_day_switch')), findsOneWidget);
    expect(find.byKey(const Key('modeartion_title')), findsOneWidget);
    expect(find.byKey(const Key('mod_notifications_tile')), findsOneWidget);
    expect(find.byKey(const Key('mod_notifications_switch')), findsOneWidget);
  });
}