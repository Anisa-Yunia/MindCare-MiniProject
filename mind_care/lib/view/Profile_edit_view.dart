import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_care/view/home_view.dart';
import 'package:mind_care/view/profile_view.dart';

// Fungsi untuk mengubah kata sandi pengguna
Future<void> updatePassword(String newPassword) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
      print('Kata sandi berhasil diubah.');
    } else {
      print('Tidak ada pengguna yang masuk.');
    }
  } catch (e) {
    print('Terjadi kesalahan saat mengubah kata sandi: $e');
  }
}

// Fungsi untuk mengubah nama pengguna
Future<void> updateDisplayName(String newDisplayName) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateProfile(displayName: newDisplayName);
      print('Nama pengguna berhasil diubah.');
    } else {
      print('Tidak ada pengguna yang masuk.');
    }
  } catch (e) {
    print('Terjadi kesalahan saat mengubah nama pengguna: $e');
  }
}

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _displayNameController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  void _refreshUser() {
    final updatedUser = FirebaseAuth.instance.currentUser;
    if (updatedUser != null) {
      setState(() {
        user = updatedUser;
      });
    }
  }

  void _updatePassword() async {
    String newPassword = _passwordController.text.trim();
    if (newPassword.isNotEmpty) {
      await updatePassword(newPassword);
      // Implement logic to handle success or error, e.g., show a Snackbar.
    }
  }

  void _updateDisplayName() async {
    String newDisplayName = _displayNameController.text.trim();
    if (newDisplayName.isNotEmpty) {
      await updateDisplayName(newDisplayName);
      // Implement logic to handle success or error, e.g., show a Snackbar.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            TextFormField(
              controller: _displayNameController,
              decoration: InputDecoration(labelText: 'New Display Name'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                _updateDisplayName();
                _updatePassword();
                // Refresh profil setelah pembaruan
                await Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
                _refreshUser();
              },
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
