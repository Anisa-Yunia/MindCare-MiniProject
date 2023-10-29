import 'package:flutter/material.dart';
import 'package:mind_care/viewModel/provider/history_user_provider.dart';
import 'package:mind_care/viewModel/widget/bottom_navigator.dart';
import 'package:provider/provider.dart';

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservasi Dokter'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => HistoryProvider(),
        child: Consumer<HistoryProvider>(
            builder: (context, historyProvider, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Pilih Tanggal dan Jam Reservasi',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Tanggal Reservasi'),
                    SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Pilih Tanggal: ${selectedDate.toLocal()}'
                          .split(' ')[0]),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Jam Reservasi'),
                    SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                      onPressed: () => _selectTime(context),
                      child: Text('Pilih Jam: ${selectedTime.format(context)}'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final newHistoryItem = {
                      "event": "Anda telah mereservasi dokter pada:",
                      "tanggal": "2023-11-01", // Ganti tanggal sesuai kebutuhan
                      "jam": "3:30 PM", // Ganti jam sesuai kebutuhan
                    };
                    String reservationDetails =
                        'Anda telah mereservasi dokter pada:\n'
                        'Tanggal: ${selectedDate.toLocal().toString().split(' ')[0]}\n'
                        'Jam: ${selectedTime.format(context)}';
                    historyProvider.addToHistory(newHistoryItem);
                    print('${historyProvider.history}');
                    // Tampilkan AlertDialog dengan detail reservasi
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Hasil Reservasi'),
                          content: Text(reservationDetails),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Tutup'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Reservasi Sekarang'),
                ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: CurvedBottomNavigationBar(),
    );
  }
}
