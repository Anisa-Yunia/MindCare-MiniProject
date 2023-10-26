import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_care/view/login_view.dart';
import 'package:mind_care/viewModel/provider/user_provider.dart';
import 'package:mind_care/viewModel/widget/bottom_navigator.dart';
import 'package:provider/provider.dart';

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
              onTap: () {
                // Navigate to the profile page
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
          ],
        ),
        bottomNavigationBar: CurvedBottomNavigationBar(),
      ),
    );
  }
}
