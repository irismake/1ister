import 'dart:convert';

class ListModel {
  final int totalListCount;
  final List<ListData> groups;

  ListModel({required this.totalListCount, required this.groups});

  ListModel.fromJson(Map<String, dynamic> json)
      : totalListCount = json['total_list_count'],
        groups = (json['groups'] as List<dynamic>)
            .map((item) => ListData.fromJson(item))
            .toList();
}

class ListData {
  final int id;
  final String name;
  final int listCount;
  final String updatedAt;

  ListData({
    required this.id,
    required this.name,
    required this.listCount,
    required this.updatedAt,
  });

  ListData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = utf8.decode(json['name'].toString().codeUnits),
        listCount = json['list_count'],
        updatedAt = json['updated_at'] as String;
}
