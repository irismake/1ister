import 'package:flutter/material.dart';

import '../keywordModel.dart';

class KeywordsProvider with ChangeNotifier {
  final List<KeywordData> _keywords = [];
  bool keywordState = false;
  int? _selectedIndex;
  String? _selectedKeyword_1;
  String? _selectedKeyword_2;

  int? get selectedIndex => _selectedIndex;

  set selectedIndex(int? index) {
    _selectedIndex = index;
    _selectedKeyword_1 = _keywords[index!].name;
    notifyListeners();
  }

  void addKeyword(KeywordData data) {
    _keywords.add(data);
    keywordState = true;
    notifyListeners();
  }

  String getKeyword_1() {
    _selectedKeyword_1 = _keywords[0].name;

    print('_selectedkeyword : $_selectedKeyword_1');
    return _selectedKeyword_1!;
  }

  String getKeyword_2() {
    _selectedKeyword_2 = _keywords[1].name;
    print('_selectedkeyword : $_selectedKeyword_2');
    return _selectedKeyword_2!;
  }

  List<KeywordData> get keywords => _keywords;
}
