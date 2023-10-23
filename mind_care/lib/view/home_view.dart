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
        title: Text('Halo, ${_currentUser.displayName} '),
      ),
      bottomNavigationBar: CurvedBottomNavigationBar(),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                elevation: 5, // Tinggi bayangan card
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text('Hai!',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Text('Bagaimana Kabarmu Hari ini ?'),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            child: Text('Ingin bercerita dengan minca?')),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Pindah ke halaman pertama
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => PageOne()));
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 25.0,
                      child: Text('1',
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () {
                      // Pindah ke halaman kedua
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => PageTwo()));
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 25.0,
                      child: Text('2',
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () {
                      // Pindah ke halaman ketiga
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => PageThree()));
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 25.0,
                      child: Text('3',
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () {
                      // Pindah ke halaman ketiga
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => PageThree()));
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 25.0,
                      child: Text('3',
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
