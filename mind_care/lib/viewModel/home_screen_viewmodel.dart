import 'package:firebase_auth/firebase_auth.dart';

class HomeScreenViewModel {
  final User user;

  HomeScreenViewModel({required this.user});

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
