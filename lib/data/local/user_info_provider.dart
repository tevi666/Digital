import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoProvider extends ChangeNotifier {
  String _firstName = '';
  String _lastName = '';

  String get firstName => _firstName;
  String get lastName => _lastName;

  static const String _firstNameKey = 'firstName';
  static const String _lastNameKey = 'lastName';

  UserInfoProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _firstName = prefs.getString(_firstNameKey) ?? '';
    _lastName = prefs.getString(_lastNameKey) ?? '';
    notifyListeners();
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_firstNameKey, _firstName);
    prefs.setString(_lastNameKey, _lastName);
  }

  void updateFirstName(String newName) {
    _firstName = newName;
    _saveData();
    notifyListeners();
  }

  void updateLastName(String newLastName) {
    _lastName = newLastName;
    _saveData();
    notifyListeners();
  }
}
