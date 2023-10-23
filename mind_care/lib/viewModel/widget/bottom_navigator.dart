import 'package:flutter/material.dart';
import 'package:mind_care/view/account_view.dart';

class CurvedBottomNavigationBar extends StatefulWidget {
  @override
  State<CurvedBottomNavigationBar> createState() =>
      _CurvedBottomNavigationBarState();
}

class _CurvedBottomNavigationBarState extends State<CurvedBottomNavigationBar> {
  //inisialisasi variabel
  int _currentIndex = 0;

  String _currentMenu = 'Home';

  //metod ini akan dijalankna saat diklik
  void _changeSelectedNavBar(int index) {
    setState(() {
      _currentIndex = index;

      if (index == Navigator.pushNamed(context, '/home')) {
        _currentMenu = 'Home';
      } else if (index == Navigator.pushNamed(context, '/chat')) {
        _currentMenu = 'Order';
      } else if (index == Navigator.pushNamed(context, '/riwayat')) {
        _currentMenu = 'Inbox';
      } else if (index == Navigator.pushNamed(context, '/profile')) {
        _currentMenu = 'Account';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0), // Melengkungkan ujung kiri
        topRight: Radius.circular(30.0), // Melengkungkan ujung kanan
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.blueGrey
            .shade300, // Ganti warna latar belakang menjadi biru abu-abu
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outlined), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],

        //currentindex mengikuti baris item bottom navigasi yang diklik
        currentIndex: _currentIndex,

        //warna saat item diklik
        selectedItemColor: Colors.white70,

        //metode yang dijalankan saat ditap
        onTap: _changeSelectedNavBar,

        //agar bottom navigation tidak bergerak saat diklik
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
