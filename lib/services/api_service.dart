import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/lists.dart';

class ApiService {
  static final storage = FlutterSecureStorage();
  static const String baseUrl = 'http://172.30.1.87:5999';
  static const String userPrefix = 'user';
  static const String listsPrefix = 'lists';

  static Future<bool> sendValidCode(String userEmailAddress) async {
    try {
      final existResponse = await http.get(
        Uri.parse('$baseUrl/$userPrefix/check-email?email=$userEmailAddress'),
      );
      if (existResponse.statusCode == 200) {
        final existData = json.decode(existResponse.body);
        if (existData['result']) {
          print('이미 사용중인 이메일');
          return true;
        } else {
          final response = await http.get(
            Uri.parse(
                '$baseUrl/$userPrefix/send-valid-code?email=$userEmailAddress'),
          );
          if (response.statusCode == 200) {
            final responseData = json.decode(response.body);
            if (responseData['ok']) {
              print('Valid 코드 전송 성공!');
            } else {
              print('Valid 코드 전송 실패!->잘못된 이메일 형식');
            }
          }
          return false;
        }
      } else {
        return true;
      }
    } catch (e) {
      print('이메일 인증 번호 전송 오류 발생: $e');
      return true;
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
          return true;
        }
      } else {
        return true;
      }
    } catch (e) {
      print('이메일 인증 번호 검사 오류 발생: $e');
      return true;
    }
  }

  static Future<bool> checkname(String userId) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/$userPrefix/check-duplicate-username?username=$userId'),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['result']) {
          print('이미 사용중인 이름입니다');
          return false;
        } else {
          print('사용 가능한 이름입니다');
          return true;
        }
      } else {
        print('사용자 아이디 중복 확인 - 상태 코드 확인 필요');
        return false;
      }
    } catch (e) {
      print('이름 중복 체크 오류: $e');
      return false;
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
        print('회원가입 실패 - 상태 코드: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('회원가입 오류: $e');
      return false;
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
        print('로그인 실패 - 상태 코드: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('로그인 오류: $e');
      return false;
    }
  }

  static Future<bool> getUserInfo(int userId, String accessToken) async {
    print(accessToken);
    final Uri uri = Uri.parse('$baseUrl/$userPrefix/info?user_id=$userId');

    try {
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$accessToken',
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('User Info: $responseData');
        return true;
      } else {
        print('Server response error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Request error: $e');
      return false;
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
        throw Exception('Server response error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Request error: $e');
    }
  }
}
