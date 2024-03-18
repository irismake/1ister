import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../services/api_service.dart';
import '../myGroupModel.dart';

class MyGroupsProvider with ChangeNotifier {
  final storage = FlutterSecureStorage();
  final List<MyGroupData> _groups = [];
  bool _isInitialized = false;

  int? _selectedIndex;

  int? get selectedIndex => _selectedIndex;

  set selectedIndex(int? index) {
    _selectedIndex = index;
    print('notifyListeners');
    notifyListeners(); // 상태가 업데이트되었음을 알림
  }

  List<MyGroupData> myGroups() {
    _initialize();
    return _groups;
  }

  void _initialize() async {
    if (!_isInitialized) {
      await _fetchMyGroups();
      _isInitialized = true;
    }
  }

  Future<void> _fetchMyGroups() async {
    //String userId = await storage.read(key: 'ACCESS_TOKEN') ?? '';
    final results = await ApiService.getMyGroups();
    _groups.clear();
    for (var result in results) {
      _groups.add(result);
    }
    notifyListeners();
  }
}
