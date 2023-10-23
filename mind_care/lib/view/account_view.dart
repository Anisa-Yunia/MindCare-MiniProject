import 'package:flutter/material.dart';
import 'package:mind_care/viewModel/widget/bottom_navigator.dart';

class akun extends StatelessWidget {
  akun({super.key});
  final List<String> menuItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: menuItems.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(menuItems[index]),
              onTap: () {
                // Tambahkan aksi yang ingin Anda lakukan saat item diklik di sini.
                // Misalnya, buka halaman terkait dengan item yang dipilih.
              },
            );
          }),
      bottomNavigationBar: CurvedBottomNavigationBar(),
    );
  }
}
