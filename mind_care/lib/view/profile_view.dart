import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_care/view/Profile_edit_view.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  void _refreshUser() {
    final updatedUser = FirebaseAuth.instance.currentUser;
    if (updatedUser != null) {
      setState(() {
        user = updatedUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              // Tampilkan foto profil jika tersedia
              backgroundImage:
                  user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
              radius: 80,
            ),
            SizedBox(height: 20),
            Text('Name: ${user?.displayName ?? "N/A"}'),
            Text('Email: ${user?.email ?? "N/A"}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman Edit Profile
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProfileEditScreen();
                }));
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
