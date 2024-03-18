import 'package:flutter/material.dart';

import '../keywordModel.dart';

class KeywordsProvider with ChangeNotifier {
  final List<KeywordData> _keywords = [];
  int? _selectedIndex;

  int? get selectedIndex => _selectedIndex;

  set selectedIndex(int? index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void addKeyword(KeywordData data) {
    _keywords.add(data);
    notifyListeners();
  }

  List<KeywordData> get keywords => _keywords;
}
