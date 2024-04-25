import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import '../list_model.dart';
import '../my_group_model.dart';

class MyGroupsProvider with ChangeNotifier {
  final List<MyGroupData> _myGroups = [];
  final List<ListData> _myGroupLists = [];
  int? totalListCount;
  bool _isInitialized = false;
  int? _selectedIndex;
  int? _selectedGroupId;
  int? _bookmarkGroupId;

  int? get selectedIndex => _selectedIndex;
  int? get bookmarkGroupId => _bookmarkGroupId;

  List<MyGroupData> get myGroups => _myGroups;
  //int get totalListCount =>

  List<ListData> get myGroupLists => _myGroupLists;

  Future<void> initializeMyGroupData() async {
    if (!_isInitialized) {
      await _fetchMyGroups();
      _isInitialized = true;
    }
  }

  Future<void> initializeMyGroupListsData() async {
    if (!_isInitialized) {
      await _fetchMyGroupLists();
      _isInitialized = true;
    }
  }

  set selectedIndex(int? index) {
    _selectedIndex = index;
    _selectedGroupId = _myGroups[index!].id;
    notifyListeners();
  }

  set bookmarkGroupId(int? index) {
    _bookmarkGroupId = index;
    notifyListeners();
  }

  int? getSelectedGroupId() {
    print('_selectedGroupId : $_selectedGroupId');
    return _selectedGroupId;
  }

  // List<MyGroupData> myGroups() {
  //   initializeMyGroupData();
  //   return _groups;
  // }

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
    _myGroups.clear();
    for (var result in myGroups) {
      _myGroups.add(result);
    }
    print('iiii${_myGroups}');
    notifyListeners();
  }

  Future<void> _fetchMyGroupLists() async {
    final results = await ApiService.getMyGroupLists(_bookmarkGroupId ?? 0);
    print(results);
    _myGroupLists.clear();
    for (var result in results) {
      _myGroupLists.add(result);
    }
    notifyListeners();
  }
}
