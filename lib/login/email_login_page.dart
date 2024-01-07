import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/custom_text_form_field.dart';

class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({Key? key}) : super(key: key);

  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  @override
  final noFocusColor = Color(0xffCED4DA);
  final brandPointColor = Color(0xff5BFF7F);

  String finalEmail = '';
  String finalPassword = '';

  bool _emailState = false;
  bool _passwordState = false;
  bool _loginButtonState = false;

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
                              finalEmail = value!;
                              if (value!.isNotEmpty) {
                                _emailState = true;
                                if (_emailState) {
                                  _loginButtonState = true;
                                }
                              } else {
                                _emailState = false;
                                _loginButtonState = false;
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
                              finalPassword = value!;
                              if (value!.isNotEmpty) {
                                _passwordState = true;
                                if (_passwordState) {
                                  _loginButtonState = true;
                                }
                              } else {
                                _passwordState = false;
                                _loginButtonState = false;
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
                        print("[final email] : $finalEmail");
                        print("[final password] : $finalPassword");
                      });
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 158.w, vertical: 20.h),
                      backgroundColor:
                          _loginButtonState ? Colors.black : noFocusColor,
                    ),
                    child: Text(
                      "로그인",
                      style: TextStyle(
                        fontFamily: 'PretendardRegular',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color:
                            _loginButtonState ? brandPointColor : Colors.white,
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
