import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../services/api_service.dart';
import '../listModel.dart';

class GetListsProvider with ChangeNotifier {
  final storage = FlutterSecureStorage();
  final List<ListData> _mainLists = [];
  final List<ListData> _usersLists = [];
  bool _isInitialized = false;
  bool _bookmarkPage = false;

  bool get bookmarkPage => _bookmarkPage;

  List<ListData> mainLists() {
    _initializeMainLists();
    return _mainLists;
  }

  List<ListData> userLists() {
    _initializeUserLists();
    return _usersLists;
  }

  void _initializeMainLists() async {
    if (!_isInitialized) {
      await _fetchMainLists();
      _isInitialized = true;
    }
  }

  void _initializeUserLists() async {
    if (!_isInitialized) {
      await _fetchUserLists();
      _isInitialized = true;
    }
  }

  Future<void> _fetchMainLists() async {
    String userId = await storage.read(key: 'USER_ID') ?? '';
    final results = await ApiService.getMainLists(userId);
    _mainLists.clear();
    for (var result in results) {
      _mainLists.add(result);
    }
    notifyListeners();
  }

  Future<void> _fetchUserLists() async {
    final results = await ApiService.getUsersLists(_bookmarkPage);
    _usersLists.clear();
    for (var result in results) {
      _usersLists.add(result);
    }
    notifyListeners();
  }

  set bookmarkPage(bool value) {
    _bookmarkPage = value;
    print('매개변수 : $_bookmarkPage');
    notifyListeners();
  }

  onTapBookMark(int index, int listId, bool isBookMarked) async {
    if (isBookMarked) {
      await ApiService.actionUnLike(listId);
      _mainLists[index].isBookmarked = false;
    } else {
      await ApiService.actionLike(listId);
      _mainLists[index].isBookmarked = true;
    }
    notifyListeners();
  }
}
