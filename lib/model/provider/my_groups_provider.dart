import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../services/api_service.dart';
import '../groups.dart';

class MyGroupsProvider with ChangeNotifier {
  final storage = FlutterSecureStorage();
  final List<MyGroupData> _groups = [];
  bool _isInitialized = false;

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
