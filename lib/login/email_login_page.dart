import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import '../model/custom_text_form_field.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({Key? key}) : super(key: key);

  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  @override
  final noFocusColor = Color(0xffCED4DA);
  final brandPointColor = Color(0xff5BFF7F);
  final storage = FlutterSecureStorage();

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
        // await storage.write(
        //     key: 'REFRESH_TOKEN', value: refreshToken);
        print(accessToken);
      } else {
        print('로그인 실패 - 상태 코드: ${response.statusCode}');
      }
    } catch (e) {
      print('로그인 오류: $e');
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
                      //color : Colors.green,
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
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        print("[final email] : $_userEmail");
                        print("[final password] : $_userPassword");
                        signIn(_userEmail,_userPassword);
                      });
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 158.w, vertical: 20.h),
                      backgroundColor:
                      _emailState && _passwordState ? Colors.black : noFocusColor,
                    ),
                    child: Text(
                      "로그인",
                      style: TextStyle(
                        fontFamily: 'PretendardRegular',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color:
                        _emailState && _passwordState ? brandPointColor : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
