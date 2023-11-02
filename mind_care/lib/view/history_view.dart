import 'package:flutter/material.dart';
import 'package:mind_care/viewModel/provider/history_user_provider.dart';
import 'package:mind_care/viewModel/widget/bottom_navigator.dart';
import 'package:provider/provider.dart';

class AllReservationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semua Reservasi'),
      ),
      body: Consumer<ReservationProvider>(
        builder: (context, reservationProvider, child) {
          return ListView.builder(
            itemCount: reservationProvider.reservations.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Reservasi ${index + 1}'),
                  subtitle:
                      Text(reservationProvider.reservations[index].toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Panggil fungsi untuk menangani pengeditan data
                      editReservation(context, reservationProvider, index);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: CurvedBottomNavigationBar(),
    );
  }

  void editReservation(
      BuildContext context, ReservationProvider provider, int index) {
    DateTime editedDate = DateTime.now(); // Tanggal awal yang akan diedit
    TimeOfDay editedTime = TimeOfDay.now(); // Jam awal yang akan diedit

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Tanggal dan Jam Reservasi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Pilih Tanggal'),
                subtitle: Text(
                  '${editedDate.day}/${editedDate.month}/${editedDate.year}',
                ),
                trailing: IconButton(
                  icon: Icon(Icons.date_range),
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: editedDate,
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2025),
                    );
                    if (selectedDate != null) {
                      editedDate = selectedDate;
                    }
                  },
                ),
              ),
              ListTile(
                title: Text('Pilih Jam'),
                subtitle: Text(
                  '${editedTime.format(context)}',
                ),
                trailing: IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: () async {
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: editedTime,
                    );
                    if (selectedTime != null) {
                      editedTime = selectedTime;
                    }
                  },
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Simpan perubahan ke data reservasi
                final editedDateTime = DateTime(
                  editedDate.year,
                  editedDate.month,
                  editedDate.day,
                  editedTime.hour,
                  editedTime.minute,
                );
                provider.editReservation(index, editedDateTime.toString());
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('Simpan'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('Batal'),
            ),
          ],
        );
      },
    );
  }
}
