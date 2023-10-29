import 'package:flutter/material.dart';
import 'dart:convert';

class HistoryProvider extends ChangeNotifier {
// Buat Map untuk merepresentasikan data userHistory dalam format JSON
  List<Map<String, String>> userHistory = [
    {
      "event": "Anda telah mereservasi dokter pada:",
      "tanggal": "2023-10-31",
      "jam": "7:01 PM",
    },
    // Tambahkan data tanggal dan jam lainnya di sini
  ];

// Konversi data ke JSON
//String userHistoryJson = jsonEncode(userHistory);

  List get history => userHistory;

  List<Map<String, String>> getHistory() {
    return userHistory;
  }

  void addToHistory(item) {
    userHistory.add(item);
    notifyListeners();
  }

  void clearHistory() {
    userHistory.clear();
    notifyListeners();
  }
}
