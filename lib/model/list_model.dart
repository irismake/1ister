import 'dart:convert';

class ListModel {
  final int nextCursor;
  final List<ListData> lists;

  ListModel({
    required this.nextCursor,
    required this.lists,
  });

  ListModel.fromJson(Map<String, dynamic> json)
      : nextCursor = json['next_cursor'],
        lists = (json['lists'] as List<dynamic>)
            .map((item) => ListData.fromJson(item))
            .toList();
}

class ListData {
  final int id;
  final String title;
  final String username;
  final String keyword1;
  final String keyword2;
  final bool isPrivate;
  final int likeCount;
  bool _isBookmarked; // 변경 가능한 속성으로 변경
  final String updatedAt;

  ListData({
    required this.id,
    required this.title,
    required this.username,
    required this.keyword1,
    required this.keyword2,
    required this.isPrivate,
    required this.likeCount,
    required bool isBookmarked, // 변경 가능한 속성으로 변경
    required this.updatedAt,
  }) : _isBookmarked = isBookmarked;

  // isBookmarked 속성의 getter 메서드
  bool get isBookmarked => _isBookmarked;

  // isBookmarked 속성의 setter 메서드
  set isBookmarked(bool value) {
    _isBookmarked = value;
  }

  ListData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = utf8.decode(json['title'].toString().codeUnits),
        username = utf8.decode(json['username'].toString().codeUnits),
        keyword1 = utf8.decode(json['keyword_1'].toString().codeUnits),
        keyword2 = utf8.decode(json['keyword_2'].toString().codeUnits),
        isPrivate = json['is_private'] as bool,
        likeCount = json['like_count'] as int,
        _isBookmarked = json['is_bookmarked'] as bool, // 변경 가능한 속성으로 변경
        updatedAt = json['updated_at'] as String;
}
