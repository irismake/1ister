import 'dart:convert';

class TestListModel {
  final int totalListCount;
  final List<TestListData> groups;

  TestListModel({required this.totalListCount, required this.groups});

  TestListModel.fromJson(Map<String, dynamic> json)
      : totalListCount = json['total_list_count'],
        groups = (json['groups'] as List<dynamic>)
            .map((item) => TestListData.fromJson(item))
            .toList();
}

class TestListData {
  final int id;
  final String name;
  final int listCount;
  final String updatedAt;

  TestListData({
    required this.id,
    required this.name,
    required this.listCount,
    required this.updatedAt,
  });

  TestListData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = utf8.decode(json['name'].toString().codeUnits),
        listCount = json['list_count'],
        updatedAt = json['updated_at'] as String;
}
