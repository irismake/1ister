import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../services/api_service.dart';
import '../lists.dart';

class MainListsProvider with ChangeNotifier {
  final List<MainListData> _mainLists = [];
  bool _isInitialized = false;

  MainListsProvider() {
    _initialize();
  }

  void _initialize() async {
    if (!_isInitialized) {
      await _fetchMainLists();
      _isInitialized = true;
    }
  }

  List<MainListData> mainLists() {
    return _mainLists;
  }

  Future<void> _fetchMainLists() async {
    final userId = await _getUserId();
    print('유저 아이디 :$userId');

    final results = await ApiService.getMainLists(userId!);
    _mainLists.clear();
    print(results);
    for (var result in results) {
      _mainLists.add(result);
      print('메인 리스트 결과 : ${result.id}');
    }
    notifyListeners();
  }

  Future<String?> _getUserId() async {
    final storage = FlutterSecureStorage();
    final userId = await storage.read(key: 'USER_ID');
    return userId;
  }
}
