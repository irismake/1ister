import 'package:flutter/material.dart';
import 'package:lister/model/user_info_model.dart';

import '../../services/api_service.dart';

class UserInfoProvider with ChangeNotifier {
  UserInfoModel _userInfo = UserInfoModel.fromJson({
    'username': '',
    'name': '',
    'picture': '',
    'bio': '',
    'is_connected_oauth': false,
    'can_change_password': false,
  });

  UserInfoModel get userInfo => _userInfo;
  bool _isInitialized = false;

  Future<void> fetchUserInfo() async {
    final results = await ApiService.getUserInfo();
    _userInfo = results;
    print('object');
    notifyListeners();
  }
}
