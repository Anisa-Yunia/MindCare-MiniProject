import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_care/view/login_view.dart';

class DrawerWid extends StatefulWidget {
  final User user;

  DrawerWid({required this.user});

  @override
  State<DrawerWid> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWid> {
  late User _currentUser;
  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(" ${_currentUser.displayName}"),
            accountEmail: Text("${_currentUser.email}"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {},
          ),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text('Pengaturan'),
              onTap: () {}),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('Log Out'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
