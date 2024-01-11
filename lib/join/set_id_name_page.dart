import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lister/join/set_password_page.dart';
import 'package:lister/model/custom_text_form_field.dart';
import 'package:http/http.dart' as http;

import '../model/join_widget.dart';
import '../model/next_page_button.dart';
import '../model/progress_bar.dart';

class SetIdNamePage extends StatefulWidget {
  final String userEmail;

  const SetIdNamePage({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<SetIdNamePage> createState() => _SetIdNamePageState();
}

class _SetIdNamePageState extends State<SetIdNamePage> {
  // final noFocusColor = Color(0xffCED4DA);
  // final darkGrayColor = Color(0xff495057);
  // final mildGrayColor = Color(0xffADB5BD);

  bool _userIdState = false;
  bool _userNameState = false;
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
      });
    });

    _userNameFocus.addListener(() {
      setState(() {
        final formKeyState = _userNameFormKey.currentState!;
        if (formKeyState.validate()) {
          formKeyState.save();
        }
      });
    });
  }

  String? _checkUserNameValid(String? value) {
    if (_userNameFocus.hasFocus) {
      return null;
    }
    if (!_userNameState) {
      _userNameState = true;
      return '이미 사용중인 이메일입니다.';
    }
    return null;
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
        appBar: ProgressBar(progress: 2, totalProgress: 3),
        body: JoinWidget(
            title: '사용자 아이디와\n이름을 정해주세요.',
            firstFieldText: '사용자 아이디',
            firstCustomForm: Form(
              key: _userIdFormKey,
              child: CustomTextFormField(
                hintText: '사용자 아이디를 설정해 주세요.',
                focusNode: _userIdFocus,
                onChanged: (value) {
                  setState(() {
                    userId = value!;
                    value == '' ? _userIdState = false : _userIdState = true;
                  });
                },
                validator: (value) {},
                keyboardType: TextInputType.name,
              ),
            ),
            firstGuideState: true,
            firstGuideText: '영어, 숫자 포함 n자 이내',
            secondFieldText: '이름',
            secondCustomForm: Form(
              key: _userNameFormKey,
              child: CustomTextFormField(
                hintText: '이름을 설정해 주세요.',
                focusNode: _userNameFocus,
                onChanged: (value) {
                  setState(() {
                    userName = value!;
                    value == ''
                        ? _userNameState = false
                        : _userNameState = true;
                  });
                },
                validator: (value) {},
                keyboardType: TextInputType.name,
              ),
            ),
            secondGuideState: true,
            secondGuideText: '한국어, 영어, 일본어 n자 이내',
            authenticationState: false,
            authenticationButton: null,
            timer: null,
            nextPageButton: NextPageButton(
              firstFieldState: _userIdState,
              secondFieldState: _userNameState,
              text: '다음',
              onPressed: () async {
                if (_userIdState && _userNameState) {
                  await checkUserName(userName);
                  final formKeyState = _userNameFormKey.currentState!;
                  if (formKeyState.validate()) {
                    formKeyState.save();
                    if (_userNameValid) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetPasswordPage(
                                  userEmail: widget.userEmail,
                                  userId: userId,
                                  userName: userName)));
                    }
                  }
                }
              },
            )),
      ),
    );
  }
}