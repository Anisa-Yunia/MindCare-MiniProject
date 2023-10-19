import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:mind_care/view/login_screen.dart';
import 'package:mind_care/firebase_options.dart';
import 'package:mind_care/login_view.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
