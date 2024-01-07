import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lister/join/set_password_page.dart';
import 'package:lister/model/custom_text_form_field.dart';
import 'package:http/http.dart' as http;

class SetIdNamePage extends StatefulWidget {
  const SetIdNamePage({Key? key}) : super(key: key);

  @override
  State<SetIdNamePage> createState() => _SetIdNamePageState();
}

class _SetIdNamePageState extends State<SetIdNamePage> {
  final noFocusColor = Color(0xffCED4DA);
  final brandPointColor = Color(0xff5BFF7F);
  final darkGrayColor = Color(0xff495057);
  final mildGrayColor = Color(0xffADB5BD);

  bool _nextButtonState = false;
  bool _userIdState = false;
  bool _userNameState = false;
  bool _userIDValid = false;
  bool _userNameValid = false;

  FocusNode _userIdFocus = FocusNode();
  FocusNode _userNameFocus = FocusNode();

  final _userIdFormKey = GlobalKey<FormState>();
  final _userNameFormKey = GlobalKey<FormState>();

  String userId = '';
  String userName = '';


  @override
  void initState() {
    super.initState();

    _userIdFocus.addListener(() {
      setState(() {
        final formKeyState = _userIdFormKey.currentState!;
        if (formKeyState.validate()) {
          formKeyState.save();
        }
        if (_userIdState && _userNameState) {
          _nextButtonState = true;
        } else {
          _nextButtonState = false;
        }
      });
    });

    _userNameFocus.addListener(() {
      setState(() {
        final formKeyState = _userNameFormKey.currentState!;
        if (formKeyState.validate()) {
          formKeyState.save();
        }
        if (_userIdState && _userNameState) {
          _nextButtonState = true;
        } else {
          _nextButtonState = false;
        }
      });
    });
  }


  Future<void> checkUserName(String userName) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://172.30.1.87:5999/user/check-duplicate-username?username=$userName'),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['result']) {
          _userNameValid = false;
          print('이미 사용중인 이름입니다');
        } else {
          _userNameValid = true;
          print('사용 가능한 이름입니다');
        }
      }
    } catch (e) {
      print('이름 중복 체크 오류: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
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
                          '사용자 아이디와\n이름을 정해주세요.',
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
                      height: 40.h,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '사용자 아이디',
                              style: TextStyle(
                                fontFamily: 'PretendardRegular',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: darkGrayColor,
                              ),
                            ),
                            Text(
                              '영어, 숫자 포함 n자 이내',
                              style: TextStyle(
                                fontFamily: 'PretendardRegular',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: mildGrayColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                        Form(
                          key: _userIdFormKey,
                          child: CustomTextFormField(
                            hintText: '사용자 아이디를 설정해 주세요.',
                            focusNode: _userIdFocus,
                            onChanged: (value) {
                              setState(() {
                                userId = value!;
                                if (value!.isNotEmpty) {
                                  _userIdState = true;

                                } else {
                                  _userIdState = false;

                                }
                              });
                            },
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '이름',
                              style: TextStyle(
                                fontFamily: 'PretendardRegular',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: darkGrayColor,
                              ),
                            ),
                            Text(
                              '한국어, 영어, 일본어 n자 이내',
                              style: TextStyle(
                                fontFamily: 'PretendardRegular',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: mildGrayColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                        Form(
                          key: _userNameFormKey,
                          child: CustomTextFormField(
                            hintText: '이름을 설정해 주세요.',
                            focusNode: _userNameFocus,
                            onChanged: (value) {
                              setState(() {
                                userName = value!;
                                if (value!.isNotEmpty) {
                                  _userNameState = true;

                                } else {
                                  _userNameState = false;

                                }
                              });
                            },
                            keyboardType: TextInputType.text,
                          ),
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
                    onPressed: () async {
                      if (_nextButtonState) {
                        await checkUserName(userName);
                        if (_userNameValid) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SetPasswordPage()));
                        }
                      }
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 158.w, vertical: 20.h),
                      backgroundColor:
                          _nextButtonState ? Colors.black : noFocusColor,
                    ),
                    child: Text(
                      "다음",
                      style: TextStyle(
                        fontFamily: 'PretendardRegular',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color:
                            _nextButtonState ? brandPointColor : Colors.white,
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
