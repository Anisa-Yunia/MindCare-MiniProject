import 'package:flutter/material.dart';
import 'package:mind_care/viewModel/provider/history_user_provider.dart';
import 'package:provider/provider.dart';

// Contoh data reservasi
List<String> reservations = [
  "Anda telah mereservasi dokter pada:",
  "Tanggal: 2023-10-31",
  "Jam: 7:01 PM",
  // Tambahkan data reservasi lainnya di sini
];

class ReservationListPage extends StatelessWidget {
  //List<String>? history;

  @override
  Widget build(BuildContext context) {
    // history = Provider.of<HistoryProvider>(context, listen: false).history;
    // print(history);
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Reservasi'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => HistoryProvider(),
        child: Consumer<HistoryProvider>(
            builder: (context, historyProvider, child) {
          if (historyProvider.history.isEmpty) {
            return CircularProgressIndicator();
          } else {
            print('Data dalam History ${historyProvider.getHistory()}');
            final userHistory = historyProvider.getHistory();
            return ListView.builder(
              itemCount: historyProvider.getHistory().length,
              itemBuilder: (context, index) {
                final event = userHistory[index]["event"];
                final tanggal = userHistory[index]["tanggal"];
                final jam = userHistory[index]["jam"];
                return ListTile(
                  title: Text("Tanggal: $tanggal"),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
