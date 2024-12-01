import 'package:flutter/material.dart';

class GlobalVariables with ChangeNotifier {
  Map<String, dynamic>?_user;
  Map<String, dynamic>? _passengerResponse;

  Map<String, dynamic>? get user => _user;
  Map<String, dynamic>? get passengerResponse => _passengerResponse;

  void setUser(Map<String, dynamic> newUser) {
    _user = newUser;
    notifyListeners();
  }

  void setPassengerResponse(dynamic newPassengerResponse) {
    _passengerResponse = newPassengerResponse;
    notifyListeners();
  }
}