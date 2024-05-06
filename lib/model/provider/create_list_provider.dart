import 'package:flutter/material.dart';

class CreateListProvider with ChangeNotifier {
  String _title = '';
  String _description = '';
  String _imageFilePath = '';
  bool _isPrivate = false;
  bool _isRankingList = false;
  int _groupId = 0;
  List<Map<int, String>> _itemTitles = [];
  List<Map<int, String>> _itemDescriptions = [];
  List<Map<int, String>> _itemTags = [];
  List<int> _itmesOrder = [0];

  String get submittedTitle => _title;
  String get submittedDescription => _description;
  String get submittedImageFilePath => _imageFilePath;
  bool get submittedIsPrivate => _isPrivate;
  bool get submittedIsRankingList => _isRankingList;
  int get submittedGroupId => _groupId;
  List<int> get itemsOrder => _itmesOrder;

  set submittedTitle(String value) {
    _title = value;
    print("CreateListProvider title: $value");
    notifyListeners();
  }

  set submittedDescription(String value) {
    _description = value;
    print("CreateListProvider description : $value");
    notifyListeners();
  }

  set submittedImageFilePath(String value) {
    _imageFilePath = value;
    print("CreateListProvider filePath: $value");
    notifyListeners();
  }

  set submittedIsPrivate(bool value) {
    _isPrivate = value;
    print("CreateListProvider is private : $value");
    notifyListeners();
  }

  set submittedIsRankingList(bool value) {
    _isRankingList = value;
    print("CreateListProvider is ranking : $value");
    notifyListeners();
  }

  set submittedGroupId(int value) {
    _groupId = value;
    print("CreateListProvider group ID : $value");
    notifyListeners();
  }

  set itemTitles(Map<int, String> itemTitle) {
    bool keyExists = false;
    for (int i = 0; i < _itemTitles.length; i++) {
      if (_itemTitles[i]
          .keys
          .toSet()
          .intersection(itemTitle.keys.toSet())
          .isNotEmpty) {
        _itemTitles[i].addAll(itemTitle);
        keyExists = true;
        break;
      }
    }
    // 같은 키값이 없으면 그대로 추가
    if (!keyExists) {
      _itemTitles.add(itemTitle);
    }

    print("CreateListProvider itemTitle: $_itemTitles");
    notifyListeners();
  }

  set itemDescriptions(Map<int, String> itemDescription) {
    bool keyExists = false;
    for (int i = 0; i < _itemDescriptions.length; i++) {
      if (_itemDescriptions[i]
          .keys
          .toSet()
          .intersection(itemDescription.keys.toSet())
          .isNotEmpty) {
        _itemDescriptions[i].addAll(itemDescription);
        keyExists = true;
        break;
      }
    }
    // 같은 키값이 없으면 그대로 추가
    if (!keyExists) {
      _itemDescriptions.add(itemDescription);
    }

    print("CreateListProvider itemDescription: $_itemDescriptions");
    notifyListeners();
  }

  set itemTags(Map<int, String> itemTag) {
    bool keyExists = false;
    for (int i = 0; i < _itemTags.length; i++) {
      if (_itemTags[i]
          .keys
          .toSet()
          .intersection(itemTag.keys.toSet())
          .isNotEmpty) {
        _itemTags[i].addAll(itemTag);
        keyExists = true;
        break;
      }
    }
    // 같은 키값이 없으면 그대로 추가
    if (!keyExists) {
      _itemTags.add(itemTag);
    }

    print("CreateListProvider itemTag: $_itemTags");
    notifyListeners();
  }

  set itemsOrder(List<int> itemOrder) {
    _itmesOrder = itemOrder;
    print("CreateListProvider itemOrder: $itemOrder");
    //notifyListeners();
  }

  List<Map<String, dynamic>> submittedItems(List<int> order) {
    List<Map<String, dynamic>> itemList = [];

    for (int index in order) {
      String? itemTitle = _itemTitles[index].containsKey(index)
          ? _itemTitles[index][index]
          : '';
      String? itemDescription = _itemDescriptions[index].containsKey(index)
          ? _itemDescriptions[index][index]
          : '';
      String? itemTag =
          _itemTags[index].containsKey(index) ? _itemTags[index][index] : '';

      itemList.add({
        "name": itemTitle,
        "description": itemDescription,
        "keyword_1": itemTag,
      });
    }

    return itemList;
  }
}
