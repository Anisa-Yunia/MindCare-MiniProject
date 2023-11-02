import 'package:carousel_slider/carousel_slider.dart';
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Pindah ke halaman pertama
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => PageOne()));
                    },
                    child: Column(
                      children: [
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
                        // Next Update
                        //       CircleAvatar(
                        //         backgroundColor: Colors.blue.shade200,
                        //         radius: 30.0,
                        //         child: Icon(
                        //           Icons.emoji_emotions,
                        //           color: Colors.white,
                        //           size: 35,
                        //         ),
                        //       ),
                        //       Text('Mood Tracker')
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(width: 10.0),
                        // GestureDetector(
                        //   onTap: () {
                        //     // Pindah ke halaman kedua
                        //     //Navigator.push(context, MaterialPageRoute(builder: (context) => PageTwo()));
                        //   },
                        //   child: Column(
                        //     children: [
                        //       CircleAvatar(
                        //           backgroundColor: Colors.green.shade200,
                        //           radius: 30.0,
                        //           child: Icon(
                        //             Icons.edit_document,
                        //             size: 30,
                        //             color: Colors.white,
                        //           )),
                        //       Text('Skrining Tes')
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              CarouselSlider(
                items: [
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdhJk27s50iAz9jC2ASsVX2RtQ-j8J3s1FjQ&usqp=CAU',
                  'data:image/jpeg;base64,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', // Ganti URL gambar pertama
                  'https://connect-assets.prosple.com/cdn/ff/mV1QjtsXspuvJ3Y0rhAEhN7nTDWl4EHkRx5FnBYOTJ8/1646743534/public/2022-03/banner-merajut-hati-893x321-2022.jpg', // Ganti URL gambar kedua
                  // Ganti URL gambar ketiga
                ].map((imageUrl) {
                  return Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          20.0), // Mengatur radius untuk lengkungan
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 150.0, // Tinggi carousel
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 150.0, // Tinggi carousel
                  enlargeCenterPage: true,
                ),
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
