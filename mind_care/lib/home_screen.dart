import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_care/view/login_view.dart';
import 'package:mind_care/viewModel/widget/bottom_navigator.dart';
import 'package:mind_care/viewModel/widget/drawer.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.deepOrangeAccent,
        //   title: Text('HomeScreen'),
        //   centerTitle: true,
        // ),
        appBar: AppBar(
          title: Text('Mindcare'),
        ),
        bottomNavigationBar: BottomNav(),
        body: WillPopScope(
          onWillPop: () async {
            final logout = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: new Text('Are you sure?'),
                  content: new Text('Do you want to logout from this App'),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    TextButton(
                      onPressed: () {
                        Logout();
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
            return logout!;
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
        drawer: DrawerWid(
          user: _currentUser,
        ));
  }

  Future<dynamic> Logout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}
