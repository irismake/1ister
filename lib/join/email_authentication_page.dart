import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lister/join/set_id_name_page.dart';
import 'package:lister/model/custom_text_form_field.dart';

class EmailAuthenticationPage extends StatefulWidget {
  const EmailAuthenticationPage({Key? key}) : super(key: key);

  @override
  State<EmailAuthenticationPage> createState() =>
      _EmailAuthenticationPageState();
}

class _EmailAuthenticationPageState extends State<EmailAuthenticationPage> {
  @override
  final noFocusColor = Color(0xffCED4DA);
  final brandPointColor = Color(0xff5BFF7F);
  final darkGrayColor = Color(0xff495057);
  final noFocusButtonColor = Color(0xffF9FAFB);
  final focusButtonColor = Color(0xffF1F3F5);

  bool _emailAddressState = false;
  bool _emailExistState = false;
  bool _timerState = false;
  bool _emailAuthenticationState = false;
  bool _checkAuthenticationState = false;
  bool _authenticationRequestButton = false;

  FocusNode _emailAddressFocus = FocusNode();
  FocusNode _emailAuthenticationFocus = FocusNode();

  final _emailAddressFormKey = GlobalKey<FormState>();
  final _emailAuthenticationFormKey = GlobalKey<FormState>();

  String userEmailAddress = '';
  String authenticationNumber = '';

  late Timer timer;
  int remainingTime = 180; // 3 minutes in seconds

  @override
  void initState() {
    super.initState();

    _emailAddressFocus.addListener(() {
      setState(() {
        final formKeyState = _emailAddressFormKey.currentState!;
        if (formKeyState.validate()) {
          formKeyState.save();
        }
      });
    });
    //
    _emailAuthenticationFocus.addListener(() {
      setState(() {
        final formKeyState = _emailAuthenticationFormKey.currentState!;
        if (formKeyState.validate()) {
          formKeyState.save();
        }
      });
    });
  }

  String? _checkEmailDuplicate(String? value) {
    if (_emailAddressFocus.hasFocus) {
     //_emailExistState = false;
      return null;

      // _emailAddressState = true;
    }
    if (_emailExistState) {
      _emailExistState = false;
      return '이미 사용중인 이메일입니다.';
    }
    if ( !_emailAddressState) {
      return '이메일을 입력해주세요.';
    }
    return null;
  }

  String? _checkAuthenticationValid(String? value) {
    if (_emailAuthenticationFocus.hasFocus) {
      _checkAuthenticationState = false;
    }
    if (_checkAuthenticationState) {
      _authenticationRequestButton = true;
      return '잘못된 인증번호에요.';
    }
    return null;
  }

  Future<void> sendValidCode(String userEmailAddress) async {
    try {
      final existResponse = await http.get(
        Uri.parse(//172.30.1.87
            'http://192.168.0.212:5999/user/check-email?email=$userEmailAddress'),
      );
      if (existResponse.statusCode == 200) {
        final existData = json.decode(existResponse.body);
        if (existData['result']) {
          _emailExistState = true;
          print('이미 사용중인 이메일');
          return;
        }else{
          _emailExistState = false;
        }
      }

      final response = await http.get(
        Uri.parse(
            'http://192.168.0.212:5999/user/send-valid-code?email=$userEmailAddress'),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['ok']) {
          print('Valid 코드 전송 성공!');
        } else {
          print('Valid 코드 전송 실패!->잘못된 이메일 형식');
        }
      }
    } catch (e) {
      print('이메일 인증 번호 전송 오류 발생: $e');
    }
  }

  Future<void> checkValidCode(String authenticationNumber) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.0.212:5999/user/check-valid-code?email=$userEmailAddress&code=$authenticationNumber'),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['is_valid']) {
          _checkAuthenticationState = false;
        } else {
          _checkAuthenticationState = true;
        }
      }
    } catch (e) {
      print('이메일 인증 번호 검사 오류 발생: $e');
    }
  }

  void startTimer() {
    _timerState ? timer.cancel() : null;
    remainingTime = 180;
    _timerState = true;
    const Duration interval = Duration(seconds: 1);

    timer = Timer.periodic(interval, (Timer timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        resetTimer();
      }
    });
  }

  void resetTimer() {
    setState(() {
      _timerState ? timer.cancel() : null;
      _timerState = false;

    });
  }

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
                          '회원가입을 위해\n'
                          '이메일을 인증해주세요.',
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '이메일 주소',
                            style: TextStyle(
                              fontFamily: 'PretendardRegular',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: darkGrayColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                        Form(
                          key: _emailAddressFormKey,
                          child: CustomTextFormField(
                            hintText: '이메일 주소',
                            focusNode: _emailAddressFocus,
                            onChanged: (value) {
                              setState(() {
                                userEmailAddress = value!;
                                value == ''
                                    ? _emailAddressState = false
                                    : _emailAddressState = true;
                              });
                            },
                            validator: (value) {
                              List<String? Function(String)> validators = [
                                _checkEmailDuplicate,
                              ];
                              for (var validator in validators) {
                                var result = validator(value!);
                                if (result != null) {
                                  resetTimer();
                                  return result;
                                }
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '이메일 인증',
                            style: TextStyle(
                              fontFamily: 'PretendardRegular',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: darkGrayColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                        Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            Form(
                              key: _emailAuthenticationFormKey,
                              child: CustomTextFormField(
                                hintText: '인증 번호',
                                focusNode: _emailAuthenticationFocus,
                                onChanged: (value) {
                                  setState(() {
                                    authenticationNumber = value!;
                                    value == ''
                                        ? _emailAuthenticationState = false
                                        : _emailAuthenticationState = true;
                                  });
                                },
                                validator: (value) {
                                  List<String? Function(String)> validators = [
                                    _checkAuthenticationValid,
                                  ];
                                  for (var validator in validators) {
                                    var result = validator(value!);
                                    if (result != null) {
                                      return result;
                                    }
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Positioned(
                              top: 21.h,
                              right: 108.w,
                              child: Text(
                                '${remainingTime ~/ 60}:${(remainingTime % 60).toString().padLeft(2, '0')}',
                                style: TextStyle(
                                    fontFamily: 'PretendardRegular',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: _timerState
                                        ? noFocusColor
                                        : Colors.transparent),
                              ),
                            ),

                            Positioned(
                              top: 12.h,
                              right: 16.w,
                              child: TextButton(
                                child: Text(
                                  _authenticationRequestButton
                                      ? '재인증'
                                      : '인증 요청',
                                  style: TextStyle(
                                      fontFamily: 'PretendardRegular',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: _emailAddressState
                                          ? darkGrayColor
                                          : noFocusColor),
                                ),
                                onPressed: () async {
                                  await sendValidCode(userEmailAddress);
                                  final formKeyState = _emailAddressFormKey.currentState!;
                                  if (formKeyState.validate()) {
                                    formKeyState.save();
                                    if (_emailAddressState && !_emailExistState) {
                                      startTimer();
                                    }
                                  }

                                  FocusScope.of(context).requestFocus(_emailAuthenticationFocus);
                                },
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 9.h),
                                    backgroundColor: _emailAddressState
                                        ? focusButtonColor
                                        : noFocusButtonColor),
                              ),
                            ),
                            // ),
                          ],
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
                      await checkValidCode(authenticationNumber);
                      setState(() {
                        if (_emailAddressState && _emailAuthenticationState) {
                          resetTimer();
                          final formKeyState =
                              _emailAuthenticationFormKey.currentState!;
                          if (formKeyState.validate()) {
                            formKeyState.save();
                            if (!_checkAuthenticationState) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SetIdNamePage(userEmail: userEmailAddress)));
                            }
                          }

                        }
                      });
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 158.w, vertical: 20.h),
                      backgroundColor:
                          _emailAddressState && _emailAuthenticationState
                              ? Colors.black
                              : noFocusColor,
                    ),
                    child: Text(
                      "다음",
                      style: TextStyle(
                        fontFamily: 'PretendardRegular',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: _emailAddressState && _emailAuthenticationState
                            ? brandPointColor
                            : Colors.white,
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
