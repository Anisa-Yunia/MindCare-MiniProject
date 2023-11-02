import 'package:flutter/material.dart';

class ReservationProvider with ChangeNotifier {
  List<String> reservations = [];

  void addReservation(String reservationDetails) {
    reservations.add(reservationDetails);
    notifyListeners();
  }

  void editReservation(int index, String newReservationDetails) {
    if (index >= 0 && index < reservations.length) {
      reservations[index] = newReservationDetails;
      notifyListeners();
    }
  }
}
