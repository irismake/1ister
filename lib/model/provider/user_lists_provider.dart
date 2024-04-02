import 'package:flutter/material.dart';

class UserListsProvider with ChangeNotifier {
  bool _bookmarkPage = false;

  bool get bookmarkPage => _bookmarkPage;

  set bookmarkPage(bool value) {
    _bookmarkPage = value;
    print('매개변수 : $_bookmarkPage');
    notifyListeners();
  }
}
