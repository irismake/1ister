import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../services/api_service.dart';
import '../../widget/custom/custom_text_form_field.dart';
import '../../widget/custom/custom_next_page_button.dart';
import '../../widget/navigator/home_page_navigator.dart';

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
                    print("[final email] : $_userEmail");
                    print("[final password] : $_userPassword");
                    bool signInState =
                        await ApiService.signIn(_userEmail, _userPassword);
                    if (signInState) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePageNavigator()),
                          (route) => false);
                    }
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
