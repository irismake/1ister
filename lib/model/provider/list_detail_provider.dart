import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../services/api_service.dart';
import '../list_detail_model.dart';

class ListDetailProvider with ChangeNotifier {
  final storage = FlutterSecureStorage();
  int? _listId;
  bool _bookmarkState = false;
  late ListDetailModel _listDetail = ListDetailModel.fromJson({
    'id': 0,
    'user_id': 0,
    'user_name': '',
    'title': '',
    'description': '',
    'is_private': false,
    'is_ranking_list': false,
    'keyword_1': '',
    'keyword_2': '',
    'shorten_url': '',
    'image_file_path': '',
    'is_deleted': false,
    'like_count': 0,
    'created_at': '',
    'updated_at': '',
    'items': [],
  });

  ListDetailModel get listDetail => _listDetail;
  int? get listId => _listId;
  bool get bookmarkState => _bookmarkState;

  Future<void> initializeListDetailData() async {
    await _fetchListDetailData();
  }

  set listId(int? index) {
    _listId = index;
    notifyListeners();
  }

  set bookmarkState(bool value) {
    _bookmarkState = value;
    notifyListeners();
  }

  Future<void> _fetchListDetailData() async {
    final results = await ApiService.getListDetail(_listId ?? 0);
    _listDetail = results;
    notifyListeners();
  }
}
