import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mind_care/view/sign_up_view.dart';

void main() {
  testWidgets('Sign-up Page UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SignUpScreen(),
    ));

    // Verify if the "Sign up" button is initially disabled.
    final signUpButton = find.text('Sign up');
    expect(signUpButton, findsOneWidget);
    final button = tester.widget<ElevatedButton>(signUpButton);
    expect(button.enabled, isFalse);

    // Enter valid data into the form fields.
    final nameField =
        find.byWidgetPredicate((widget) => widget is TextFormField);
    final emailField =
        find.byWidgetPredicate((widget) => widget is TextFormField);
    final passwordField =
        find.byWidgetPredicate((widget) => widget is TextFormField);

    await tester.enterText(nameField, 'John Doe');
    await tester.enterText(emailField, 'johndoe@example.com');
    await tester.enterText(passwordField, 'securePassword');

    // Verify if the "Sign up" button is now enabled after entering valid data.
    expect(button.enabled, isTrue);

    // Tap the "Sign up" button.
    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    // Verify that the new screen or widget is displayed after a successful sign-up.
    final successMessage = find.text('Successfully Registered!');
    expect(successMessage, findsOneWidget);
  });
}
