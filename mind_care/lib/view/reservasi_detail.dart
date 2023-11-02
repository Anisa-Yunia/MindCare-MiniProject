import 'package:flutter/material.dart';
import 'package:mind_care/view/history_view.dart';
import 'package:mind_care/view/reservasi_view.dart';
import 'package:mind_care/viewModel/provider/history_user_provider.dart';
import 'package:provider/provider.dart';

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  List<String> reservations = [];

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

  void _navigateToResultPage(BuildContext context) {
    final reservationDetails = 'Anda telah mereservasi dokter pada:\n'
        'Tanggal: ${selectedDate.toLocal().toString().split(' ')[0]}\n'
        'Jam: ${selectedTime.format(context)}';

    // Menggunakan Provider untuk menambahkan reservasi
    Provider.of<ReservationProvider>(context, listen: false)
        .addReservation(reservationDetails);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultPage(
          reservationDetails: reservationDetails,
        ),
      ),
    );
  }

  void _navigateToAllReservationsPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AllReservationsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservasi Dokter'),
      ),
      body: Center(
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Pilih Tanggal dan Jam Reservasi',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Pilih Tanggal Reservasi')),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text('Pilih Jam '),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _navigateToResultPage(context);
                },
                child: Text('Reservasi Sekarang'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final String reservationDetails;

  ResultPage({
    required this.reservationDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Reservasi'),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Hasil Reservasi',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Text(reservationDetails),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CardReservasi()));
                  },
                  child: Text('Reservasi Lagi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
