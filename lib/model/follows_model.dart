import 'dart:convert';

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
      : username = utf8.decode(json['username'].toString().codeUnits),
        name = utf8.decode(json['name'].toString().codeUnits),
        picture = utf8.decode(json['picture'].toString().codeUnits),
        bio = utf8.decode(json['bio'].toString().codeUnits);
}
