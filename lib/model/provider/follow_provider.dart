import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import '../followModel.dart';

class GetFollowsProvider with ChangeNotifier {
  FollowsModel _followsData = FollowsModel(
    followingCount: 0,
    followerCount: 0,
    followers: [],
    followings: [],
  );
  bool _isInitialized = false;
  bool _pageState = false;

  bool get pageState => _pageState;

  FollowsModel followsData() {
    _initializefollowsData();
    return _followsData;
  }

  void _initializefollowsData() async {
    if (!_isInitialized) {
      await _fetchfollowsData();
      _isInitialized = true;
    }
  }

  Future<void> _fetchfollowsData() async {
    _followsData = await ApiService.getUserFollows();

    notifyListeners();
  }

  set pageState(bool value) {
    _pageState = value;

    notifyListeners();
  }
}
