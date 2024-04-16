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

  int get usersFollowerCount => _usersFollowerCount;
  int get usersFollowingCount => _usersFollowingCount;

  List<FollowData> get usersFollowerLists => _usersFollowerLists;
  List<FollowData> get usersFollowingLists => _usersFollowingLists;

  Future<void> initializeData() async {
    if (!_isInitialized) {
      await _fetchFollowsData();
      _isInitialized = true;
    }
  }

  Future<void> _fetchFollowsData() async {
    final results = await ApiService.getUserFollows();
    _usersFollowerCount = results.followerCount;
    _usersFollowingCount = results.followingCount;
    _usersFollowerLists.clear();
    _usersFollowingLists.clear();
    _usersFollowerLists.addAll(results.followers);
    _usersFollowingLists.addAll(results.followings);

    notifyListeners();
  }

  set pageState(bool value) {
    _pageState = value;
    notifyListeners();
  }
}