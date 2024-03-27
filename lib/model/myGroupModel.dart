import 'dart:convert';

class MyGroupsModel {
  final int totalListCount;
  final List<MyGroupData> groups;

  MyGroupsModel({required this.totalListCount, required this.groups});

  MyGroupsModel.fromJson(Map<String, dynamic> json)
      : totalListCount = json['total_list_count'],
        groups = (json['groups'] as List<dynamic>)
            .map((item) => MyGroupData.fromJson(item))
            .toList();
}

class MyGroupData {
  final int id;
  final String name;
  final int listCount;
  final String updatedAt;

  MyGroupData({
    required this.id,
    required this.name,
    required this.listCount,
    required this.updatedAt,
  });

  MyGroupData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = utf8.decode(json['name'].toString().codeUnits),
        listCount = json['list_count'],
        updatedAt = json['updated_at'] as String;
}
