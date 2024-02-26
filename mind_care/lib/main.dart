//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//import 'package:mind_care/view/account_view.dart';
import 'package:mind_care/view/chatbot_view.dart';
import 'package:mind_care/view/home_view.dart';
import 'package:mind_care/view/login_view.dart';
import 'package:mind_care/view/onboardingscreen/spalsh.dart';
import 'package:mind_care/view/onboardingscreen/splasshscreen_view.dart';

import 'package:mind_care/view/reservasi_detail.dart';
//import 'package:mind_care/view/reservasi_view.dart';
import 'package:mind_care/viewModel/provider/history_user_provider.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'viewModel/provider/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCXUXmRaHgDhOIT7WgYTCzwwntGp-yKFYY',
    appId: '1:652046343209:android:f9dd9936ffe9c3d67d9038',
    messagingSenderId: '652046343209',
    projectId: 'mindcare-project',
    storageBucket: 'mindcare-project.appspot.com',
  );
  await Firebase.initializeApp(options: android); // Initialize Firebase

  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider<ReservationProvider>(
            create: (context) => ReservationProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey.shade300),
        useMaterial3: true,
      ),
      home: MyAppWithNavigation(),
    );
  }
}

class MyAppWithNavigation extends StatelessWidget {
  const MyAppWithNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey.shade300),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          User? user = userProvider.user;

          return Navigator(
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/':
                  return MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  );
                case '/login':
                  return MaterialPageRoute(
                    builder: (context) => SplashScreen(),
                  );
                case '/home':
                  return MaterialPageRoute(
                    builder: (context) =>
                        user != null ? HomeScreen(user: user) : LoginScreen(),
                  );
                case '/chat':
                  return MaterialPageRoute(
                    builder: (context) => ChatbotPage(),
                  );
                case '/reservasi':
                  return MaterialPageRoute(
                    builder: (context) => ReservationPage(),
                  );
                default:
                  return MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  );
              }
            },
          );
        },
      ),
    );
  }
}
