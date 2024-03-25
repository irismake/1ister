import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import '../myGroupModel.dart';

class MyGroupsProvider with ChangeNotifier {
  final List<MyGroupData> _groups = [];
  bool _isInitialized = false;
  int? _selectedIndex;
  int? _selectedGroupId;

  int? get selectedIndex => _selectedIndex;

  set selectedIndex(int? index) {
    _selectedIndex = index;
    _selectedGroupId = _groups[index!].id;
    notifyListeners();
  }

  int? getSelectedGroupId() {
    print('_selectedGroupId : $_selectedGroupId');
    return _selectedGroupId;
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
    final results = await ApiService.getMyGroups();
    _groups.clear();
    for (var result in results) {
      _groups.add(result);
    }
    notifyListeners();
  }
}
