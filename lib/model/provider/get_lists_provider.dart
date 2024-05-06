import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../services/api_service.dart';
import '../list_model.dart';

class GetListsProvider with ChangeNotifier {
  final storage = FlutterSecureStorage();
  final List<ListData> _mainLists = [];
  final List<ListData> _usersMyLists = [];
  final List<ListData> _usersBookmarkLists = [];
  bool _isInitialized = false;
  bool _pageState = false;
  bool _changeBookmarked = false;

  bool get pageState => _pageState;

  List<ListData> get usersMyLists => _usersMyLists;

  List<ListData> get usersBookmarkLists => _usersBookmarkLists;

  List<ListData> mainLists() {
    _initializeMainLists();
    return _mainLists;
  }

  void _initializeMainLists() async {
    if (!_isInitialized) {
      await _fetchMainLists();
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

  Future<void> _fetchUsersMyLists() async {
    final results = await ApiService.getUsersLists(false);
    _usersMyLists.clear();
    for (var result in results) {
      _usersMyLists.add(result);
    }
    notifyListeners();
  }

  Future<void> _fetchUsersBookmarkLists() async {
    final results = await ApiService.getUsersLists(true);
    _usersBookmarkLists.clear();
    for (var result in results) {
      _usersBookmarkLists.add(result);
    }
    notifyListeners();
  }

  Future<void> initializeData() async {
    if (!_isInitialized) {
      await _fetchUsersMyLists();
      await _fetchUsersBookmarkLists();
      _isInitialized = true;
    }
  }

  set pageState(bool value) {
    _pageState = value;

    if (_changeBookmarked) {
      if (_pageState) {
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

    if (_pageState) {
      _fetchUsersBookmarkLists();
    }
    notifyListeners();
  }
}
