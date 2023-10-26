import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mind_care/view/account_view.dart';
import 'package:mind_care/view/chatbot_view.dart';
import 'package:mind_care/view/home_view.dart';
import 'package:mind_care/view/login_view.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'viewModel/provider/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDMMGPpYYWSfVmSaTnilwvsnkzHYFYtBc',
    appId: '1:901581989215:android:976c25e252dbcbe8b602ea',
    messagingSenderId: '901581989215',
    projectId: 'mind-care-minpro',
    storageBucket: 'mind-care-minpro.appspot.com',
  );
  await Firebase.initializeApp(options: android); // Initialize Firebase

  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey.shade300),
        useMaterial3: true,
      ),
      home: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          User? user = userProvider.user;

          return Navigator(
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/login':
                  return MaterialPageRoute(
                    builder: (context) => LoginScreen(),
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
