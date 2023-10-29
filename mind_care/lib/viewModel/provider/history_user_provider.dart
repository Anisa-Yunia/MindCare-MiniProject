import 'package:flutter/material.dart';

class HistoryProvider extends ChangeNotifier {
  List<String> userHistory = [
    "Anda telah mereservasi dokter pada:",
    "Tanggal: 2023-10-31",
    "Jam: 7:01 PM",
    // Tambahkan data tanggal dan jam lainnya di sini
  ];

  List<String> get history => userHistory;

  void addToHistory(String item) {
    userHistory.add(item);
    notifyListeners();
  }

  void clearHistory() {
    userHistory.clear();
    notifyListeners();
  }
}
