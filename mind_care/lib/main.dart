import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mind_care/view/home_view.dart';
import 'package:mind_care/view/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDMMGPpYYWSfVmSaTnilwvsnkzHYFYtBc',
    appId: '1:901581989215:android:976c25e252dbcbe8b602ea',
    messagingSenderId: '901581989215',
    projectId: 'mind-care-minpro',
    storageBucket: 'mind-care-minpro.appspot.com',
  );
  await Firebase.initializeApp(options: android);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey.shade300),
        useMaterial3: true,
      ),

      initialRoute: '/login', // Rute awal
      routes: {
        '/login': (context) => LoginScreen(),
        // '/homeScreen': (context) => HomeScreen(user: user,),
        // '/chat': (context) => ChatScreen(),
        // '/riwayat': (context) => RiwayatScreen(),
        // '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
