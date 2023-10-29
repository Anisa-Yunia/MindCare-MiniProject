import 'package:flutter/material.dart';
import 'package:mind_care/viewModel/provider/dokter_provider.dart';
import 'package:provider/provider.dart';

class CardReservasi extends StatefulWidget {
  @override
  _CardReservasiState createState() => _CardReservasiState();
}

class _CardReservasiState extends State<CardReservasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Orang'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => DokterProvider(),
        child: Consumer<DokterProvider>(
          builder: (context, userProvider, child) {
            if (userProvider.userData.isEmpty) {
              userProvider.fetchData(); // Fetch data if it's empty
              return CircularProgressIndicator(); // Display a loading indicator
            } else {
              return ListView.builder(
                itemCount: userProvider.userData.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(16.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(userProvider.userData[index].avatar),
                      ),
                      title: Text(' ${userProvider.userData[index].name}'),
                      subtitle: Text(
                          'Usia: ${userProvider.userData[index].profession} '
                          //tahun\nPekerjaan: ${people[index].occupation}'
                          ),
                      trailing: Column(
                        children: [
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Tambahkan aksi yang ingin Anda lakukan ketika tombol ditinggikan ditekan di sini.
                            },
                            child: Text('Reservasi'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
