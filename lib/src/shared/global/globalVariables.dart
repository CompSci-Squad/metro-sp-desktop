import 'package:flutter/material.dart';

class GlobalVariables with ChangeNotifier {
  Map<String, dynamic>? _user;
  Map<String, dynamic>? _passengerResponse;
  List<Map<String, dynamic>>? _logs;

  Map<String, dynamic>? get user => _user;
  Map<String, dynamic>? get passengerResponse => _passengerResponse;
  List<Map<String, dynamic>>? get logs => _logs;

  void setUser(Map<String, dynamic> newUser) {
    _user = newUser;
    notifyListeners();
  }

  void setPassengerResponse(dynamic newPassengerResponse) {
    _passengerResponse = newPassengerResponse;
    notifyListeners();
  }

  void setLogs(List<Map<String, dynamic>> newLogs) {
    _logs = newLogs;
    notifyListeners();
  }
}
