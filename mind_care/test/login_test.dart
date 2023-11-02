import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mind_care/view/home_view.dart';
import 'package:mind_care/view/login_view.dart';
import 'package:mind_care/view/sign_up_view.dart'; // Sesuaikan dengan impor sebenarnya

void main() {
  testWidgets('UI Test for LoginScreen', (WidgetTester tester) async {
    // Bangun widget LoginScreen
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(),
    ));

    // Cari elemen-elemen dalam widget
    final emailField = find.widgetWithText(TextFormField, 'Email');
    final passwordField = find.widgetWithText(TextFormField, 'Password');
    final signInButton = find.text('Sign In');
    final signUpButton = find.text('Sign Up');

    // Uji input pada TextFormField
    await tester.enterText(emailField, 'anis@gmail.com');
    await tester.enterText(passwordField, '123456789');

    // Tekan tombol Sign In
    await tester.tap(signInButton);
    await tester.pumpAndSettle(); // Tunggu animasi selesai (jika ada)

    // Pastikan navigasi ke HomeScreen berhasil jika login sukses
    expect(find.byType(HomeScreen), findsOneWidget);

    // Tekan tombol Sign Up
    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    // Pastikan navigasi ke SignUpScreen berhasil
    expect(find.byType(SignUpScreen), findsOneWidget);
  });
}
