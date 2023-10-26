import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import pustaka http
import 'dart:convert';

import 'package:mind_care/models/dokter.dart'; // Import pustaka json

class CardReservasi extends StatefulWidget {
  @override
  _CardReservasiState createState() => _CardReservasiState();
}

class _CardReservasiState extends State<CardReservasi> {
  List<Map<String, dynamic>> userData = [];
  Dio dio = Dio();
  String url = 'https://65389e61a543859d1bb1a570.mockapi.io/user';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        setState(() {
          userData = List<Map<String, dynamic>>.from(response.data);
        });
      } else {
        print('Gagal mengambil data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Orang'),
      ),
      body: ListView.builder(
        itemCount: userData.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(16.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(userData[index]['avatar']),
              ),
              title: Text(' ${userData[index]['name']}'),
              subtitle: Text('Usia: ${userData[index]['Profesi']} '
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
      ),
    );
  }
}
