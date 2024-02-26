import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_care/view/login_view.dart';
import 'package:mind_care/view/profile_view.dart';

import 'package:mind_care/viewModel/provider/user_provider.dart';
import 'package:mind_care/viewModel/widget/bottom_navigator.dart';
import 'package:provider/provider.dart';

Future<void> deleteAccount(BuildContext context) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Show an alert dialog to confirm account deletion
      bool deleteConfirmed = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: Text('Are you sure you want to delete your account?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(false); // User canceled the deletion
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(true); // User confirmed the deletion
                },
                child: Text('Delete'),
              ),
            ],
          );
        },
      );

      if (deleteConfirmed == true) {
        // Hapus akun pengguna
        await user.delete();

        // Show success dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Account Deleted'),
              content: Text('Your account has been successfully deleted.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the success dialog
                    // Navigate to login page or any other appropriate screen
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );

        print('Akun berhasil dihapus.');
      }
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
          bottomNavigationBar: CurvedBottomNavigationBar(),
          body: ListView(padding: EdgeInsets.zero, children: <Widget>[
            SizedBox(
              height: 50,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
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
                bool deleteConfirmed = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmation'),
                      content:
                          Text('Are you sure you want to delete your account?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pop(false); // User canceled the deletion
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pop(true); // User confirmed the deletion
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    );
                  },
                );

                if (deleteConfirmed == true) {
                  await deleteAccount(
                      context); // Pass the context to the deleteAccount function

                  // After account deletion, logout from Firebase Authentication
                  await FirebaseAuth.instance.signOut();

                  // Navigate to the login screen or the initial screen of the application
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              },
            ),
          ]),
        ));
  }
}
