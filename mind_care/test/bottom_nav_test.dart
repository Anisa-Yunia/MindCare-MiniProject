import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mind_care/viewModel/provider/user_provider.dart';
import 'package:mind_care/viewModel/widget/bottom_navigator.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('UI Test for CurvedBottomNavigationBar',
      (WidgetTester tester) async {
    // Bangun widget CurvedBottomNavigationBar
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<UserProvider>(
                create: (_) =>
                    UserProvider()), // Pastikan Anda memiliki provider UserProvider yang sesuai
          ],
          child: Scaffold(
            bottomNavigationBar: CurvedBottomNavigationBar(),
          ),
        ),
      ),
    );

    // Cek bahwa inisialisasi index terjadi dengan benar
    expect(find.text('Home'), findsOneWidget);

    // Tekan ikon "Chat"
    await tester.tap(find.byIcon(Icons.chat_bubble_outlined));
    await tester.pumpAndSettle();

    // Pastikan navigasi ke halaman "Chat" terjadi dengan benar
    expect(find.text('Chat'), findsOneWidget);

    // Tekan ikon "History"
    await tester.tap(find.byIcon(Icons.history));
    await tester.pumpAndSettle();

    // Pastikan navigasi ke halaman "History" terjadi dengan benar
    expect(find.text('History'), findsOneWidget);

    // Tekan ikon "Account"
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    // Pastikan navigasi ke halaman "Account" terjadi dengan benar
    expect(find.text('Account'), findsOneWidget);
  });
}
