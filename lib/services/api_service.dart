import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/lists.dart';

class ApiService {
  static final storage = FlutterSecureStorage();
  static const String baseUrl = 'http://172.30.1.87:5999';
  static const String userPrefix = 'user';
  static const String listsPrefix = 'lists';
  static const String actionsPrefix = 'actions';

  static Future<bool> sendValidCode(String userEmailAddress) async {
    try {
      final checkEmailResponse = await http.get(
        Uri.parse('$baseUrl/$userPrefix/check-email?email=$userEmailAddress'),
      );
      if (checkEmailResponse.statusCode == 200) {
        final checkEmailResponseData = json.decode(checkEmailResponse.body);
        if (checkEmailResponseData['result']) {
          throw Exception(
              'Response data error <checkEmail> : ${checkEmailResponseData['result']}');
        }
        try {
          final response = await http.get(
            Uri.parse(
                '$baseUrl/$userPrefix/send-valid-code?email=$userEmailAddress'),
          );
          if (response.statusCode == 200) {
            final responseData = json.decode(response.body);
            if (responseData['ok']) {
              return false;
            } else {
              throw Exception(
                  'Response data error <sendValidCode> : ${responseData['ok']}');
            }
          } else {
            throw Exception(
                'Response code error <sendValidCode> : ${response.statusCode}');
          }
        } catch (e) {
          throw Exception('Request error <sendValidCode> : $e');
        }
      } else {
        throw Exception(
            'Response code error <checkEmail> : ${checkEmailResponse.statusCode}');
      }
    } catch (e) {
      throw Exception('Request error <checkEmail> : $e');
    }
  }

  static Future<bool> checkValidCode(
      String userEmailAddress, String authenticationNumber) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/$userPrefix/check-valid-code?email=$userEmailAddress&code=$authenticationNumber'),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['is_valid']) {
          return false;
        } else {
          throw Exception(
              'Response data error <checkValidCode> : ${responseData['is_valid']}');
        }
      } else {
        throw Exception(
            'Response code error <checkValidCode> : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Request error <checkValidCode> : $e');
    }
  }

  static Future<bool> checkDuplicateUserName(String userName) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/$userPrefix/check-duplicate-username?username=$userName'),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['result']) {
          throw Exception('이미 사용중인 이름입니다');
        } else {
          return true;
        }
      } else {
        throw Exception(
            'Response code error <checkDuplicateUserName> : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Request error <checkDuplicateUserName> : $e');
    }
  }

  static Future<bool> signUp(
      String name, String email, String password, String username) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/$userPrefix/signup');

      final Map<String, dynamic> requestBody = {
        "name": name,
        "email": email,
        "password": password,
        "username": username,
      };

      final http.Response response = await http.post(
        uri,
        body: json.encode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
        bool signInState = await signIn(email, password);
        return signInState;
      } else {
        throw Exception(
            'Response code error <signUp> : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Request error <signUp> : $e');
    }
  }

  static Future<bool> signIn(String email, String password) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/$userPrefix/signin');

      final Map<String, dynamic> requestBody = {
        "email": email,
        "password": password,
      };

      final http.Response response = await http.post(
        uri,
        body: json.encode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        int userId = responseData['user_id'];
        String accessToken = responseData['access_token'];
        await storage.write(key: 'ACCESS_TOKEN', value: accessToken);
        await storage.write(key: 'USER_ID', value: userId.toString());
        return true;
      } else {
        throw Exception(
            'Response code error <signIn> : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Request error <signIn> : $e');
    }
  }

  static Future<Map<String, dynamic>> getUserInfo() async {
    final accessToken = await storage.read(key: 'ACCESS_TOKEN');
    final userId = await storage.read(key: 'USER_ID');
    final Uri uri = Uri.parse('$baseUrl/$userPrefix/info?user_id=$userId');

    try {
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$accessToken',
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData;
      } else {
        throw Exception(
            'Response code error <getUserInfo> : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Request error <getUserInfo> : $e');
    }
  }

  static Future<Map<String, dynamic>> getUserFollows() async {
    final accessToken = await storage.read(key: 'ACCESS_TOKEN');
    final Uri uri = Uri.parse('$baseUrl/$userPrefix/follows');

    try {
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$accessToken',
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData;
      } else {
        throw Exception(
            'Response code error <getUserInfo> : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Request error <getUserInfo> : $e');
    }
  }

  static Future<bool> updateUserInfo(
      String userName, String name, String picture, String bio) async {
    final accessToken = await storage.read(key: 'ACCESS_TOKEN');

    final Uri uri = Uri.parse('$baseUrl/$userPrefix/update');
    try {
      final Map<String, dynamic> requestBody = {
        "username": userName,
        "name": name,
        "picture": picture,
        "bio": bio,
      };

      final http.Response response = await http.post(
        uri,
        body: json.encode(requestBody),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$accessToken',
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('response : $responseData');
        return true;
      } else {
        throw Exception(
            'Response code error <userUpdate> : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Request error <userUpdate> : $e');
    }
  }

  static Future<List<MainListData>> getMainLists(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$listsPrefix/main?user_id=$userId'),
      );
      if (response.statusCode == 200) {
        final mainListsData = json.decode(response.body);

        MainListsModel mainListsModel = MainListsModel.fromJson(mainListsData);

        return Future.value(mainListsModel.lists);
      } else {
        throw Exception(
            'Response code error <getMainLists> : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Request error <getMainLists> : $e');
    }
  }

  static Future<Map<String, dynamic>> getListDetail(int listId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$listsPrefix/$listId'),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData;
      } else {
        throw Exception(
            'Response code error <getListDetail> : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Request error <getListDetail> : $e');
    }
  }

  static Future<bool> actionLike(int listId) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/$actionsPrefix/like');
      final Map<String, dynamic> requestBody = {
        "user_id": 13,
        "list_id": listId
      };

      final http.Response response = await http.post(
        uri,
        body: json.encode(requestBody),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': await storage.read(key: 'ACCESS_TOKEN') ?? '',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('User Info: $responseData');
        return true;
      } else {
        throw Exception(
            'Response code error <actionLike> : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Request error <actionLike> : $e');
    }
  }

  static Future<bool> actionUnLike(int listId) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/$actionsPrefix/unlike');
      final Map<String, dynamic> requestBody = {
        "user_id": 13,
        "list_id": listId
      };

      final http.Response response = await http.post(
        uri,
        body: json.encode(requestBody),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': await storage.read(key: 'ACCESS_TOKEN') ?? '',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('User Info: $responseData');
        return true;
      } else {
        throw Exception(
            'Response code error <actionUnLike> : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Request error <actionUnLike> : $e');
    }
  }
}
