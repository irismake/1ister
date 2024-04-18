import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import '../my_group_model.dart';

class MyGroupsProvider with ChangeNotifier {
  final List<MyGroupData> _groups = [];
  int? totalListCount;
  bool _isInitialized = false;
  int? _selectedIndex;
  int? _selectedGroupId;

  int? get selectedIndex => _selectedIndex;

  List<MyGroupData> get groups => _groups;
  //int get totalListCount =>

  Future<void> initializeData() async {
    if (!_isInitialized) {
      await _fetchMyGroups();
      _isInitialized = true;
    }
  }

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
    initializeData();
    return _groups;
  }

  // void _initialize() async {
  //   if (!_isInitialized) {
  //     await _fetchMyGroups();
  //     _isInitialized = true;
  //   }
  // }

  Future<void> _fetchMyGroups() async {
    final results = await ApiService.getMyGroups();
    List<MyGroupData> myGroups = results.groups;
    totalListCount = results.totalListCount;
    _groups.clear();
    for (var result in myGroups) {
      _groups.add(result);
    }
    print('iiii${_groups}');
    notifyListeners();
  }
}
