import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mind_care/main.dart';
import 'package:mind_care/view/chatbot_view.dart';
import 'package:mind_care/view/home_view.dart';
import 'package:mind_care/view/login_view.dart';

void main() {
  testWidgets('Test navigation', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Ensure the app starts on the LoginScreen.
    expect(find.byType(LoginScreen), findsOneWidget);

    // Tap a button to navigate to the HomeScreen.
    await tester.tap(find.byKey(const Key('home_button')));
    await tester.pumpAndSettle();

    // Ensure that we are on the HomeScreen.
    expect(find.byType(HomeScreen), findsOneWidget);

    // Tap a button to navigate to the ChatbotPage.
    await tester.tap(find.byKey(const Key('chat_button')));
    await tester.pumpAndSettle();

    // Ensure that we are on the ChatbotPage.
    expect(find.byType(ChatbotPage), findsOneWidget);

    // You can continue to add more test cases for navigation to other screens here.
  });
}
