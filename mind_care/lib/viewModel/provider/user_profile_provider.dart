import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:mind_care/models/user_profile.dart';

class UserProfileProvider with ChangeNotifier {
  List<UserProfile> _items = [];
  Dio dio = Dio();
  String url = 'https://65389e61a543859d1bb1a570.mockapi.io/users';

  List<UserProfile> get items => _items;

  Future<void> fetchUserProfile() async {
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        _items = (response.data as List<dynamic>)
            .map((items) => UserProfile(
                  name: items['name'],
                  email: items['Email'],
                  address: items['addres'],
                  phoneNumber: items['telepon'],
                  id: items['id'],
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
