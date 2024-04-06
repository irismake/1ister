class FollowsModel {
  final int followingCount;
  final int followerCount;
  final List<FollowData> followers;
  final List<FollowData> followings;

  FollowsModel({
    required this.followingCount,
    required this.followerCount,
    required this.followers,
    required this.followings,
  });

  factory FollowsModel.fromJson(Map<String, dynamic> json) {
    List<FollowData> followers = (json['followers'] as List<dynamic>)
        .map((item) => FollowData.fromJson(item))
        .toList();

    List<FollowData> followings = (json['followings'] as List<dynamic>)
        .map((item) => FollowData.fromJson(item))
        .toList();

    return FollowsModel(
      followingCount: json['following_count'] as int,
      followerCount: json['follower_count'] as int,
      followers: followers,
      followings: followings,
    );
  }
}

class FollowData {
  final String username;
  final String name;
  final String picture;
  final String bio;

  FollowData({
    required this.username,
    required this.name,
    required this.picture,
    required this.bio,
  });

  factory FollowData.fromJson(Map<String, dynamic> json) {
    return FollowData(
      username: json['username'] as String,
      name: json['name'] as String,
      picture: json['picture'] as String,
      bio: json['bio'] as String,
    );
  }
}
