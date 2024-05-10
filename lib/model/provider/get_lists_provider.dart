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

  List<ListData> get mainLists => _mainLists;

  List<ListData> get usersMyLists => _usersMyLists;

  List<ListData> get usersBookmarkLists => _usersBookmarkLists;

  Future<void> initializeMainLists() async {
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

  onTapBookMark(int listId, bool isBookMarked) async {
    // 서버에 좋아요/싫어요 요청을 보냅니다.
    if (isBookMarked) {
      await ApiService.actionUnLike(listId);
    } else {
      await ApiService.actionLike(listId);
    }

    // 리스트들의 isBookmarked 값을 업데이트합니다.
    updateIsBookmarked(listId, !isBookMarked);

    // 사용자의 북마크 리스트를 다시 가져옵니다.
    if (_pageState) {
      _fetchUsersBookmarkLists();
    }

    // 이하 주석 처리한 코드들은 필요에 따라 주석을 해제하여 사용합니다.
    // _fetchMainLists();
    // _fetchUsersMyLists();
    notifyListeners();
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
  }

  int findListIndex(List<ListData> list, int listId) {
    return list.indexWhere((element) => element.id == listId);
  }
}
