import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:lister/model/home_page_navigator.dart';
import '../../model/custom_text_form_field.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../model/next_page_button.dart';

class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({Key? key}) : super(key: key);

  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  @override
  final noFocusColor = Color(0xffCED4DA);
  static final storage = FlutterSecureStorage();
  dynamic userInfo = '';

  String _userEmail = '';
  String _userPassword = '';

  bool _emailState = false;
  bool _passwordState = false;

  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();

  Future<void> signIn(String email, String password) async {
    try {
      final Uri uri = Uri.parse('http://172.30.1.87:5999/user/signin');

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

        await _getUserInfo(userId, accessToken);
      } else {
        print('로그인 실패 - 상태 코드: ${response.statusCode}');
      }
    } catch (e) {
      print('로그인 오류: $e');
    }
  }

  Future<void> _getUserInfo(int userId, String accessToken) async {
    print(accessToken);
    final Uri uri =
        Uri.parse('http://172.30.1.87:5999/user/info?user_id=$userId');

    try {
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$accessToken',
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('User Info: $responseData');
        Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePageNavigator()),
        );
      } else {
        print('Server response error: ${response.statusCode}');
      }
    } catch (e) {
      print('Request error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 88.h),
                child: Column(
                  children: [
                    Container(
                      height: 80.h,
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        child: Text(
                          '가입하신 아이디와\n'
                          '비밀번호를 입력해주세요.',
                          style: TextStyle(
                            fontFamily: 'PretendardRegular',
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48.h,
                    ),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextFormField(
                          hintText: '이메일',
                          focusNode: _emailFocus,
                          onChanged: (value) {
                            setState(() {
                              _userEmail = value!;
                              if (value!.isNotEmpty) {
                                _emailState = true;
                              } else {
                                _emailState = false;
                              }
                            });
                          },
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        CustomTextFormField(
                          hintText: '비밀번호',
                          focusNode: _passwordFocus,
                          isObscureText: true,
                          onChanged: (value) {
                            setState(() {
                              _userPassword = value!;
                              if (value!.isNotEmpty) {
                                _passwordState = true;
                              } else {
                                _passwordState = false;
                              }
                            });
                          },
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: NextPageButton(
                  firstFieldState: _emailState,
                  secondFieldState: _passwordState,
                  text: '로그인',
                  onPressed: () async {
                    setState(() {
                      print("[final email] : $_userEmail");
                      print("[final password] : $_userPassword");
                      signIn(_userEmail, _userPassword);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
