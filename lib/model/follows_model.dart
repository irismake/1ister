class FollowModel {
  final int followingCount;
  final int followerCount;
  final List<FollowData> followers;
  final List<FollowData> followings;

  FollowModel({
    required this.followingCount,
    required this.followerCount,
    required this.followers,
    required this.followings,
  });

  FollowModel.fromJson(Map<String, dynamic> json)
      : followingCount = json['following_count'],
        followerCount = json['follower_count'],
        followers = (json['followers'] as List<dynamic>)
            .map((item) => FollowData.fromJson(item))
            .toList(),
        followings = (json['followings'] as List<dynamic>)
            .map((item) => FollowData.fromJson(item))
            .toList();
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

  FollowData.fromJson(Map<String, dynamic> json)
      : username = json['username'] as String,
        name = json['name'] as String,
        picture = json['picture'] as String,
        bio = json['bio'] as String;
}
