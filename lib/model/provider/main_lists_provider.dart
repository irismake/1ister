import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../services/api_service.dart';
import '../lists.dart';

class MainListsProvider with ChangeNotifier {
  final storage = FlutterSecureStorage();
  final List<MainListData> _mainLists = [];
  bool _isInitialized = false;

  List<MainListData> mainLists() {
    _initialize();
    return _mainLists;
  }

  void _initialize() async {
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

  onTapBookMark(int index, int listId, bool isBookMarked) async {
    if (isBookMarked) {
      await ApiService.actionUnLike(listId);
      _mainLists[index].isBookmarked = false;
      print(!_mainLists[index].isBookmarked);
      print('싫어요!');
    } else {
      await ApiService.actionLike(listId);
      _mainLists[index].isBookmarked = true;
      print(!_mainLists[index].isBookmarked);
      print('좋아요');
    }
    notifyListeners();
  }
}
