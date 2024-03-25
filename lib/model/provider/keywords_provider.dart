import 'package:flutter/material.dart';

import '../keywordModel.dart';

class KeywordsProvider with ChangeNotifier {
  final List<KeywordData> _keywords = [];
  int? _selectedIndex;
  late String _selectedKeyword_1;
  String? _selectedKeyword_2;

  int? get selectedIndex => _selectedIndex;

  set selectedIndex(int? index) {
    _selectedIndex = index;
    _selectedKeyword_1 = _keywords[index!].name;
    notifyListeners();
  }

  void addKeyword(KeywordData data) {
    _keywords.add(data);
    notifyListeners();
  }

  String getKeyword() {
    print('_selectedkeyword : $_selectedKeyword_1');
    return _selectedKeyword_1;
  }

  List<KeywordData> get keywords => _keywords;
}
