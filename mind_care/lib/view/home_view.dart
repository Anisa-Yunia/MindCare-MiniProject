import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_care/view/chatbot_view.dart';
import 'package:mind_care/view/login_view.dart';
import 'package:mind_care/view/reservasi_view.dart';
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
        body: SingleChildScrollView(
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
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatbotPage()));
                              },
                              child: Text('chat dengan minca?')),
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
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue.shade200,
                            radius: 30.0,
                            child: Icon(
                              Icons.emoji_emotions,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          Text('Mood Tracker')
                        ],
                      ),
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        // Pindah ke halaman kedua
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => PageTwo()));
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.green.shade200,
                              radius: 30.0,
                              child: Icon(
                                Icons.edit_document,
                                size: 30,
                                color: Colors.white,
                              )),
                          Text('Skrining Tes')
                        ],
                      ),
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        // Pindah ke halaman ketiga
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CardReservasi()));
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.orange.shade200,
                              radius: 30.0,
                              child: Icon(
                                Icons.people_alt,
                                color: Colors.white,
                                size: 30,
                              )),
                          Text('Konsultasi')
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
              ],
            ),
          ),
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
