import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mind_care/view/reservasi_detail.dart';
import 'package:provider/provider.dart';
import 'package:mind_care/viewModel/provider/history_user_provider.dart'; // Sesuaikan dengan path sebenarnya

void main() {
  testWidgets('UI Test for ReservationPage and ResultPage',
      (WidgetTester tester) async {
    // Bangun widget ReservationPage
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<ReservationProvider>(
                create: (_) =>
                    ReservationProvider()), // Pastikan Anda memiliki provider yang sesuai
          ],
          child: ReservationPage(),
        ),
      ),
    );

    // Cek bahwa widget ReservationPage telah dibangun dengan benar
    expect(find.text('Reservasi Dokter'), findsOneWidget);
    expect(find.text('Pilih Tanggal dan Jam Reservasi'), findsOneWidget);

    // Tekan tombol "Pilih Tanggal Reservasi"
    await tester.tap(find.text('Pilih Tanggal Reservasi'));
    await tester.pumpAndSettle();

    // Pastikan dialog pemilihan tanggal muncul
    expect(find.text('OK'), findsOneWidget);

    // Tekan tombol "OK" di dialog pemilihan tanggal
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Tekan tombol "Pilih Jam"
    await tester.tap(find.text('Pilih Jam'));
    await tester.pumpAndSettle();

    // Pastikan dialog pemilihan jam muncul
    expect(find.text('OK'), findsOneWidget);

    // Tekan tombol "OK" di dialog pemilihan jam
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Tekan tombol "Reservasi Sekarang"
    await tester.tap(find.text('Reservasi Sekarang'));
    await tester.pumpAndSettle();

    // Pastikan widget ResultPage muncul
    expect(find.text('Hasil Reservasi'), findsOneWidget);

    // Tekan tombol "Reservasi Lagi"
    await tester.tap(find.text('Reservasi Lagi'));
    await tester.pumpAndSettle();

    // Pastikan kembali ke widget ReservationPage
    expect(find.text('Reservasi Dokter'), findsOneWidget);

    // Bangun widget ResultPage
    await tester.pumpWidget(
      MaterialApp(
        home: ResultPage(reservationDetails: 'Sample Reservation Details'),
      ),
    );

    // Cek bahwa widget ResultPage telah dibangun dengan benar
    expect(find.text('Hasil Reservasi'), findsOneWidget);
    expect(find.text('Sample Reservation Details'), findsOneWidget);

    // Tekan tombol "Reservasi Lagi"
    await tester.tap(find.text('Reservasi Lagi'));
    await tester.pumpAndSettle();

    // Pastikan kembali ke widget ReservationPage
    expect(find.text('Reservasi Dokter'), findsOneWidget);
  });
}
