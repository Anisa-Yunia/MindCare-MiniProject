import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../models/dokter.dart';

class UserProvider with ChangeNotifier {
  List<User> _userData = [];
  Dio dio = Dio();
  String url = 'https://65389e61a543859d1bb1a570.mockapi.io/user';

  List<User> get userData => _userData;

  Future<void> fetchData() async {
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        _userData = (response.data as List<dynamic>)
            .map((userData) => User(
                  name: userData['name'],
                  profession: userData['Profesi'],
                  avatar: userData['avatar'],
                ))
            .toList();

        notifyListeners();
      } else {
        print('Gagal mengambil data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
    }
  }
}
