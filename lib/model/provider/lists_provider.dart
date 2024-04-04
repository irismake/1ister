import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../services/api_service.dart';
import '../listModel.dart';

class GetListsProvider with ChangeNotifier {
  final storage = FlutterSecureStorage();
  final List<ListData> _mainLists = [];
  final List<ListData> _usersMyLists = [];
  final List<ListData> _usersBookmarkLists = [];
  bool _isInitialized = false;
  bool _isInitialized_1 = false;
  bool _isInitialized_2 = false;
  bool _bookmarkPage = false;
  bool _changeBookmarked = false;

  bool get bookmarkPage => _bookmarkPage;

  List<ListData> mainLists() {
    _initializeMainLists();
    return _mainLists;
  }

  List<ListData> usersMyLists() {
    _initializeUsersMyLists();
    return _usersMyLists;
  }

  List<ListData> usersBookmarkLists() {
    _initializeUsersBookmarkLists();
    return _usersBookmarkLists;
  }

  void _initializeMainLists() async {
    if (!_isInitialized) {
      await _fetchMainLists();
      _isInitialized = true;
    }
  }

  void _initializeUsersMyLists() async {
    if (!_isInitialized_1) {
      await _fetchUsersMyLists();
      _isInitialized_1 = true;
    }
  }

  void _initializeUsersBookmarkLists() async {
    if (!_isInitialized_2) {
      await _fetchUsersBookmarkLists();
      _isInitialized_2 = true;
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

  Future<void> _fetchUsersMyLists() async {
    final results = await ApiService.getUsersLists(_bookmarkPage);
    _usersMyLists.clear();
    for (var result in results) {
      _usersMyLists.add(result);
    }
    notifyListeners();
  }

  Future<void> _fetchUsersBookmarkLists() async {
    final results = await ApiService.getUsersLists(_bookmarkPage);
    _usersBookmarkLists.clear();
    for (var result in results) {
      _usersBookmarkLists.add(result);
    }
    notifyListeners();
  }

  set bookmarkPage(bool value) {
    _bookmarkPage = value;

    if (_changeBookmarked) {
      if (_bookmarkPage) {
        _fetchUsersBookmarkLists();
      }
    }
    _changeBookmarked = false;
    notifyListeners();
  }

  onTapBookMark(int index, int listId, bool isBookMarked, String tag) async {
    if (isBookMarked) {
      await ApiService.actionUnLike(listId);
      if (tag == 'mainList') {
        _mainLists[index].isBookmarked = false;
      }
      if (tag == 'myList') {
        _usersMyLists[index].isBookmarked = false;
      }
      if (tag == 'bookmarkList') {
        _usersBookmarkLists[index].isBookmarked = false;
      }
    } else {
      await ApiService.actionLike(listId);
      if (tag == 'mainList') {
        _mainLists[index].isBookmarked = true;
      }
      if (tag == 'myList') {
        _usersMyLists[index].isBookmarked = true;
      }
      if (tag == 'bookmarkList') {
        _usersBookmarkLists[index].isBookmarked = true;
      }
    }
    _changeBookmarked = true;

    if (_bookmarkPage) {
      _fetchUsersBookmarkLists();
    }
    notifyListeners();
  }
}
