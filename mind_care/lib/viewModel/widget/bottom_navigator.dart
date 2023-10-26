import 'package:flutter/material.dart';
import 'package:mind_care/view/account_view.dart';
import 'package:mind_care/view/chatbot_view.dart';
import 'package:mind_care/view/home_view.dart';
import 'package:mind_care/view/login_view.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class CurvedBottomNavigationBar extends StatefulWidget {
  @override
  State<CurvedBottomNavigationBar> createState() =>
      _CurvedBottomNavigationBarState();
}

class _CurvedBottomNavigationBarState extends State<CurvedBottomNavigationBar> {
  int _currentIndex = 0;
  String _currentMenu = 'Home';

  void _changeSelectedNavBar(int index) {
    final userProvider = Provider.of<UserProvider>(context,
        listen: false); // Access the UserProvider

    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _currentMenu = 'Home';
          final user = userProvider.user;
          if (user != null) {
            // Navigate to HomeScreen if the user is not null
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(user: user)));
          } else {
            // Navigate to LoginScreen if the user is null
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
          break;
        case 1:
          _currentMenu = 'Chat';
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChatbotPage()));
          break;
        case 2:
          _currentMenu = 'History';
          break;
        case 3:
          _currentMenu = 'Account';
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MenuScreen()),
          );
          break;
        default:
          _currentMenu = 'Unknown';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.blueGrey.shade300,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outlined),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white70,
        onTap: _changeSelectedNavBar,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
