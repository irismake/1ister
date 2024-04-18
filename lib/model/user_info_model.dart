import 'dart:convert';

class UserInfoModel {
  final String username;
  final String name;
  final String picture;
  final String bio;
  final bool isConnectedOauth;
  final bool canChangePassword;

  UserInfoModel({
    required this.username,
    required this.name,
    required this.picture,
    required this.bio,
    required this.isConnectedOauth,
    required this.canChangePassword,
  });

  UserInfoModel.fromJson(Map<String, dynamic> json)
      : username = utf8.decode(json['username'].toString().codeUnits),
        name = utf8.decode(json['name'].toString().codeUnits),
        picture = utf8.decode(json['picture'].toString().codeUnits),
        bio = utf8.decode(json['bio'].toString().codeUnits),
        isConnectedOauth = json['is_connected_oauth'],
        canChangePassword = json['can_change_password'];
}
