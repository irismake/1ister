import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../services/api_service.dart';
import '../../model/lists.dart';

class MainListsProvider with ChangeNotifier {
  final List<MainListsModel> _mainLists = List.empty(growable: true);

  List<MainListsModel> mainLists() {
    _fetchMainLists();

    return _mainLists;
  }

  void _fetchMainLists() async {
    final userId = await _getUserId();
    print('유저 아이디 :$userId');
    final result = await ApiService.getMainLists(userId!);
    _mainLists.clear();

    //_mainLists.addAll(result as Iterable<MainLists>);
    print('메인 리스트 결과 : $_mainLists');
    notifyListeners();
  }

  Future<String?> _getUserId() async {
    final storage = FlutterSecureStorage();
    await Future.delayed(Duration(seconds: 2));
    final userId = await storage.read(key: 'USER_ID');
    return userId;
  }
}
