import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import '../list_model.dart';
import '../my_group_model.dart';

class MyGroupsProvider with ChangeNotifier {
  final List<MyGroupData> _myGroups = [];
  final List<MyGroupData> _isBucketGroup = [];
  final List<ListData> _myGroupLists = [];

  bool _isInitialized = false;
  bool _isInitialized2 = false;
  int? _selectedIndex;
  int? _selectedGroupId;
  int? _bookmarkGroupId;

  int? get selectedIndex => _selectedIndex;
  int? get bookmarkGroupId => _bookmarkGroupId;

  List<MyGroupData> get myGroups => _myGroups;
  List<MyGroupData> get isBucketGroup => _isBucketGroup;
  List<ListData> get myGroupLists => _myGroupLists;

  Future<void> initializeMyGroupData() async {
    if (!_isInitialized) {
      await fetchMyGroups();
      await fetchIsBucketGroup();
      _isInitialized = true;
      print('내 그룹 초기화');
    }
  }

  Future<void> initializeMyGroupListsData() async {
    if (!_isInitialized2) {
      await fetchMyGroupBookmarkLists();
      print('dddd');
      _isInitialized2 = true;
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

  Future<void> fetchMyGroups() async {
    final results = await ApiService.getMyGroups(false);
    List<MyGroupData> myGroups = results.groups;
    _myGroups.clear();
    for (var result in myGroups) {
      _myGroups.add(result);
    }
  }

  Future<void> fetchIsBucketGroup() async {
    final results = await ApiService.getMyGroups(true);
    List<MyGroupData> isBucketGroup = results.groups;
    _isBucketGroup.clear();
    for (var result in isBucketGroup) {
      _isBucketGroup.add(result);
    }
    notifyListeners();
  }

  Future<void> fetchMyGroupBookmarkLists() async {
    print('그룹 아이디 잘 가져왔나$_bookmarkGroupId');
    final results = await ApiService.getMyGroupLists(_bookmarkGroupId ?? 0);
    _myGroupLists.clear();
    for (var result in results) {
      if (result.isBookmarked) {
        _myGroupLists.add(result);
      }
    }
    notifyListeners();
  }
}
