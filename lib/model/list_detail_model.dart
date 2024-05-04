import 'dart:convert';

import 'package:intl/intl.dart';

class ListDetailModel {
  final int id;
  final int userId;
  final String userName;
  final String title;
  final String description;
  final bool isPrivate;
  final bool isRankingList;
  final String keyword1;
  final String keyword2;
  final String shortenUrl;
  final String imageFilePath;
  final bool isDeleted;
  final int likeCount;
  final String createdAt;
  final String updatedAt;
  final List<ItemData> items;

  ListDetailModel(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.title,
      required this.description,
      required this.isPrivate,
      required this.isRankingList,
      required this.keyword1,
      required this.keyword2,
      required this.shortenUrl,
      required this.imageFilePath,
      required this.isDeleted,
      required this.likeCount,
      required this.createdAt,
      required this.updatedAt,
      required this.items});

  ListDetailModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        userName = json['user_name'],
        title = json['title'],
        description = json['description'],
        isPrivate = json['is_private'],
        isRankingList = json['is_ranking_list'],
        keyword1 = json['keyword_1'],
        keyword2 = json['keyword_2'],
        shortenUrl = json['shorten_url'],
        imageFilePath = json['image_file_path'],
        isDeleted = json['is_deleted'],
        likeCount = json['like_count'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        items = (json['items'] as List<dynamic>)
            .map((item) => ItemData.fromJson(item))
            .toList();
}

class ItemData {
  final String name;
  final String description;
  final String keyword1;
  final int id;
  final String createdAt;
  final String updatedAt;

  ItemData({
    required this.name,
    required this.description,
    required this.keyword1,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  ItemData.fromJson(Map<String, dynamic> json)
      : name = utf8.decode(json['name'].toString().codeUnits),
        description = utf8.decode(json['description'].toString().codeUnits),
        keyword1 = utf8.decode(json['keyword_1'].toString().codeUnits),
        id = json['id'] as int,
        createdAt = DateFormat('yy.MM.dd')
            .format(DateTime.parse(json['created_at'] as String)),
        updatedAt = DateFormat('yy.MM.dd')
            .format(DateTime.parse(json['updated_at'] as String));
}
