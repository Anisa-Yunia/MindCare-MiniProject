import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mind_care/view/account_view.dart';
import 'package:mind_care/view/login_view.dart';
// Adjust the import path based on your project structure

void main() {
  testWidgets('Test Log Out button', (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(
      MaterialApp(
        home: MenuScreen(),
      ),
    );

    // Find the "Log Out" ListTile
    final logOutTileFinder = find.widgetWithText(ListTile, 'Log Out');

    // Tap on the "Log Out" ListTile
    await tester.tap(logOutTileFinder);
    await tester.pump();

    // Expect that the user is presented with the confirmation dialog
    final dialogFinder = find.byType(AlertDialog);
    expect(dialogFinder, findsOneWidget);

    // Find and tap the "Yes" button in the dialog
    final yesButtonFinder = find.widgetWithText(TextButton, 'Yes');
    await tester.tap(yesButtonFinder);
    await tester.pump();

    // Expect that the user is logged out and taken to the LoginScreen
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
