class ListsModel {
  final int nextCursor;
  final List<ListData> lists;

  ListsModel({required this.nextCursor, required this.lists});

  ListsModel.fromJson(Map<String, dynamic> json)
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
        title = json['title'] as String,
        username = json['username'] as String,
        keyword1 = json['keyword_1'] as String,
        keyword2 = json['keyword_2'] as String,
        isPrivate = json['is_private'] as bool,
        likeCount = json['like_count'] as int,
        _isBookmarked = json['is_bookmarked'] as bool, // 변경 가능한 속성으로 변경
        updatedAt = json['updated_at'] as String;
}
