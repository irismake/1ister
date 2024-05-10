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
  bool __isInitialized2 = false;
  bool _pageState = false;

  bool get pageState => _pageState;

  List<ListData> get mainLists => _mainLists;

  List<ListData> get usersMyLists => _usersMyLists;

  List<ListData> get usersBookmarkLists => _usersBookmarkLists;

  Future<void> initializeMainLists() async {
    if (!_isInitialized) {
      await _fetchMainLists();
      _isInitialized = true;
    }
  }

  Future<void> initializeData() async {
    if (!__isInitialized2) {
      await _fetchUsersMyLists();
      await _fetchUsersBookmarkLists();
      __isInitialized2 = true;
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
  }

  Future<void> _fetchUsersBookmarkLists() async {
    final results = await ApiService.getUsersLists(true);
    _usersBookmarkLists.clear();
    for (var result in results) {
      _usersBookmarkLists.add(result);
    }
    notifyListeners();
  }

  set pageState(bool value) {
    _pageState = value;
    notifyListeners();
  }

  onTapBookMark(int listId, bool isBookMarked) async {
    if (isBookMarked) {
      await ApiService.actionUnLike(listId);
    } else {
      await ApiService.actionLike(listId);
    }
    updateIsBookmarked(listId, !isBookMarked);
  }

  void updateIsBookmarked(int listId, bool isBookMarked) {
    int mainListIndex = findListIndex(_mainLists, listId);
    int usersMyListIndex = findListIndex(_usersMyLists, listId);
    int usersBookmarkListIndex = findListIndex(_usersBookmarkLists, listId);

    if (mainListIndex != -1) {
      _mainLists[mainListIndex].isBookmarked = isBookMarked;
    }
    if (usersMyListIndex != -1) {
      _usersMyLists[usersMyListIndex].isBookmarked = isBookMarked;
    }
    if (usersBookmarkListIndex != -1) {
      _usersBookmarkLists[usersBookmarkListIndex].isBookmarked = isBookMarked;
    }
    _fetchUsersBookmarkLists();
  }

  int findListIndex(List<ListData> list, int listId) {
    return list.indexWhere((element) => element.id == listId);
  }
}
