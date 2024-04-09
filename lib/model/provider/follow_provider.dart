import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import '../followModel.dart';

class GetFollowsProvider with ChangeNotifier {
  int _usersFollowerCount = 0;
  int _usersFollowingCount = 0;
  final List<FollowData> _usersFollowerLists = [];
  final List<FollowData> _usersFollowingLists = [];

  bool _pageState = false;
  bool _isInitialized = false;

  bool get pageState => _pageState;

  // int get usersFollowerCount => _usersFollowerCount;
  // int get usersFollowingCount => _usersFollowingCount;

  // set usersFollowerCount(int value) {
  //   _initializefollowsData();
  //   usersFollowerCount = value;
  //   notifyListeners();
  // }

  // set usersFollowingCount(int value) {
  //   _initializefollowsData();
  //   usersFollowingCount = value;
  //   notifyListeners();
  // }

  int usersFollowerCount() {
    _initializefollowsData();
    return _usersFollowerCount;
  }

  int usersFollowingCount() {
    _initializefollowsData();
    return _usersFollowingCount;
  }

  List<FollowData> usersFollowerLists() {
    _initializefollowsData();
    return _usersFollowerLists;
  }

  List<FollowData> usersFollowingLists() {
    _initializefollowsData();
    return _usersFollowingLists;
  }

  void _initializefollowsData() async {
    if (!_isInitialized) {
      await _fetchfollowsData();
      _isInitialized = true;
    }
  }

  Future<void> _fetchfollowsData() async {
    final results = await ApiService.getUserFollows();
    _usersFollowerCount = results.followerCount;
    _usersFollowingCount = results.followingCount;
    _usersFollowerLists.clear();
    _usersFollowingLists.clear();
    final usersFollowingResults = results.followings;
    final usersFollowerResults = results.followers;
    for (var result in usersFollowingResults) {
      _usersFollowingLists.add(result);
    }
    for (var result in usersFollowerResults) {
      _usersFollowerLists.add(result);
    }
    notifyListeners();
  }

  set pageState(bool value) {
    _pageState = value;

    notifyListeners();
  }
}
