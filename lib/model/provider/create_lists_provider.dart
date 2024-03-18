import 'package:flutter/material.dart';

class CreateListsProvider with ChangeNotifier {
  String _title = '';

  String get submittedTitle => _title;

  set submittedTitle(String value) {
    _title = value;
    print("CreateListsProvider $value");
    notifyListeners();
  }
}
