import 'package:flutter/material.dart';
import 'package:mind_care/view/history_view.dart';
import 'package:mind_care/view/reservasi_detail.dart';
import 'package:mind_care/viewModel/provider/dokter_provider.dart';
import 'package:mind_care/viewModel/widget/bottom_navigator.dart';
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
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${userProvider.userData[index].profession}'),
                          Text('${userProvider.userData[index].topic}'),
                        ],
                      ),
                      trailing: Column(
                        children: [
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ReservationPage()));
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
      bottomNavigationBar: CurvedBottomNavigationBar(),
    );
  }
}
