import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import '../follows_model.dart';

class FollowsProvider with ChangeNotifier {
  int _usersFollowerCount = 0;
  int _usersFollowingCount = 0;
  final List<FollowData> _usersFollowerLists = [];
  final List<FollowData> _usersFollowingLists = [];

  bool _pageState = false;

  bool get pageState => _pageState;

  int get usersFollowerCount => _usersFollowerCount;
  int get usersFollowingCount => _usersFollowingCount;

  List<FollowData> get usersFollowerLists => _usersFollowerLists;
  List<FollowData> get usersFollowingLists => _usersFollowingLists;

  Future<void> initializeData() async {
    await _fetchFollowsData();
  }

  Future<void> _fetchFollowsData() async {
    final results = await ApiService.getUserFollows();
    _usersFollowerCount = results.followerCount;
    _usersFollowingCount = results.followingCount;

    _usersFollowerLists
      ..clear()
      ..addAll(results.followers);
    _usersFollowingLists
      ..clear()
      ..addAll(results.followings);
    final followerIdSet =
        _usersFollowerLists.map((follower) => follower.id).toSet();

    for (var following in _usersFollowingLists) {
      following.isFollow = true;
      if (followerIdSet.contains(following.id)) {
        _usersFollowerLists
            .firstWhere((follower) => follower.id == following.id)
            .isFollow = true;
      }
    }
    notifyListeners();
  }

  onTapFollowButton(
      BuildContext context, int followUserId, bool isFollow) async {
    if (isFollow) {
      await ApiService.actionUnfollow(followUserId);
    } else {
      await ApiService.actionFollow(followUserId);
    }
    _fetchFollowsData();
  }

  set pageState(bool value) {
    _pageState = value;
    notifyListeners();
  }
}
