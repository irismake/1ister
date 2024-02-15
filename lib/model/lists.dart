class MainListsModel {
  final int listNextCursors;
  final List<MainListData> lists;

  MainListsModel({required this.listNextCursors, required this.lists});

  MainListsModel.fromJson(Map<String, dynamic> json)
      : listNextCursors = json['next_cursor'],
        lists = (json['lists'] as List<dynamic>)
            .map((item) => MainListData.fromJson(item))
            .toList();
}

class MainListData {
  final int id;
  final String title;
  final String username;
  final String keyword1;
  final String keyword2;
  final bool isPrivate;
  final int likeCount;
  final bool isBookmarked;
  final String updatedAt;

  MainListData({
    required this.id,
    required this.title,
    required this.username,
    required this.keyword1,
    required this.keyword2,
    required this.isPrivate,
    required this.likeCount,
    required this.isBookmarked,
    required this.updatedAt,
  });

  MainListData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'] as String,
        username = json['username'] as String,
        keyword1 = json['keyword_1'] as String,
        keyword2 = json['keyword_2'] as String,
        isPrivate = json['is_private'] as bool,
        likeCount = json['like_count'] as int,
        isBookmarked = json['is_bookmarked'] as bool,
        updatedAt = json['updated_at'] as String;
}
