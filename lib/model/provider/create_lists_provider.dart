import 'package:flutter/material.dart';

class CreateListsProvider with ChangeNotifier {
  String _title = '';
  String _description = '';
  String _imageFilePath = '';
  bool _isPrivate = false;
  bool _isRankingList = false;
  int _groupId = 0;
  List<Map<dynamic, String>> _itemTitles = [];
  List<Map<dynamic, String>> _itemDescriptions = [];
  List<Map<dynamic, String>> _itemTags = [];

  String get submittedTitle => _title;
  String get submittedDescription => _description;
  String get submittedImageFilePath => _imageFilePath;
  bool get submittedIsPrivate => _isPrivate;
  bool get submittedIsRankingList => _isRankingList;
  int get submittedGroupId => _groupId;
  List<Map<dynamic, String>> get itemTitles => _itemTitles;
  List<Map<dynamic, String>> get itemDescriptions => _itemDescriptions;
  List<Map<dynamic, String>> get itemTags => _itemTags;

  set submittedTitle(String value) {
    _title = value;
    print("CreateListsProvider title: $value");
    notifyListeners();
  }

  set submittedDescription(String value) {
    _description = value;
    print("CreateListsProvider description : $value");
    notifyListeners();
  }

  set submittedImageFilePath(String value) {
    _imageFilePath = value;
    print("CreateListsProvider filePath: $value");
    notifyListeners();
  }

  set submittedIsPrivate(bool value) {
    _isPrivate = value;
    print("CreateListsProvider is private : $value");
    notifyListeners();
  }

  set submittedIsRankingList(bool value) {
    _isRankingList = value;
    print("CreateListsProvider is ranking : $value");
    notifyListeners();
  }

  set submittedGroupId(int value) {
    _groupId = value;
    print("CreateListsProvider group ID : $value");
    notifyListeners();
  }

  set itemTitles(dynamic value) {
    _itemTitles.add(value);
    print("CreateListsProvider itemTitle: $_itemTitles");
    notifyListeners();
  }

  set itemDescriptions(dynamic value) {
    _itemDescriptions.add(value);
    print("CreateListsProvider itemDescription: $value");
    notifyListeners();
  }

  set itemTags(dynamic value) {
    _itemTags.add(value);
    print("CreateListsProvider itemTag: $value");
    notifyListeners();
  }

  List<Map<String, dynamic>> submittedItems() {
    List<Map<String, dynamic>> itemList = List.generate(
      _itemTitles.length,
      (index) {
        String? itemTitle = _itemTitles[index].containsKey('[<$index>]')
            ? _itemTitles[index]['[<$index>]']
            : '';
        String? itemDescription =
            _itemDescriptions[index].containsKey('[<$index>]')
                ? _itemDescriptions[index]['[<$index>]']
                : '';
        String? itemTag = _itemDescriptions[index].containsKey('[<$index>]')
            ? _itemDescriptions[index]['[<$index>]']
            : '';
        return {
          "name": itemTitle,
          "description": itemDescription,
          "keyword_1": itemTag,
        };
      },
    );
    return itemList;
  }
}
