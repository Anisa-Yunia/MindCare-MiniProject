import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_care/view/login_view.dart';

import 'package:mind_care/viewModel/provider/user_provider.dart';
import 'package:mind_care/viewModel/widget/bottom_navigator.dart';
import 'package:provider/provider.dart';

Future<void> deleteAccount() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Hapus akun pengguna
      await user.delete();

      print('Akun berhasil dihapus.');
    } else {
      print('Tidak ada pengguna yang masuk.');
    }
  } catch (e) {
    print('Terjadi kesalahan saat menghapus akun: $e');
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    Future<void> _logout() async {
      await FirebaseAuth.instance.signOut();
      userProvider.setUser(null); // Clear user data
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    }

    return WillPopScope(
      onWillPop: () async {
        final logout = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to logout from this App'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    _logout();
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return logout ?? false;
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Riwayat'),
              onTap: () {
                // Handle history page navigation
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Log Out'),
              onTap: _logout,
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Hapus Akun'),
              onTap: () async {
                await deleteAccount(); // Panggil fungsi untuk menghapus akun

                // Setelah akun dihapus, logout dari Firebase Authentication
                await FirebaseAuth.instance.signOut();

                // Navigasi ke layar login atau layar awal aplikasi (sesuai kebutuhan Anda)
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginScreen())); // Gantilah dengan rute yang sesuai
              },
            ),
          ],
        ),
        bottomNavigationBar: CurvedBottomNavigationBar(),
      ),
    );
  }
}
