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

  bool _nextButtonState = false;
  bool _emailAddressState = false;
  bool _emailExistState = false;
  bool _emailDuplicateState = false;
  bool _timerState = false;
  bool _emailAuthenticationState = false;
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
        if (_emailAddressState && _emailAuthenticationState) {
          _nextButtonState = true;
        } else {
          _nextButtonState = false;
        }
      });
    });

    _emailAuthenticationFocus.addListener(() {
      setState(() {
        final formKeyState = _emailAuthenticationFormKey.currentState!;
        if (formKeyState.validate()) {
          formKeyState.save();
        }
        if (_emailAddressState && _emailAuthenticationState) {
          _nextButtonState = true;
        } else {
          _nextButtonState = false;
        }
      });
    });
  }

  Future<void> sendValidCode(String userEmailAddress) async {
    try {
      // final duplicateResponse = await http.get(
      //   Uri.parse(
      //       'http://172.30.1.87:5999/user/check-duplicate-email?email=$userEmailAddress'),
      // );
      //
      // final existResponse = await http.get(
      //   Uri.parse(
      //       'http://172.30.1.87:5999/user/check-email?email=$userEmailAddress'),
      // );
      //
      // if (duplicateResponse.statusCode == 200 && existResponse.statusCode == 200) {
      //   final duplicateData = json.decode(duplicateResponse.body);
      //   final existData = json.decode(existResponse.body);
      //
      //   if (duplicateData['result']){
      //     _emailDuplicateState = true;
      //     print('이미 존재 하는 이메일');
      //     return;
      //   }
      //   if (!existData['result']) {
      //     _emailExistState = true;
      //     print('존재하지 않는 이메일');
      //     return;
      //   }

        // Proceed with sending validation code
        final response = await http.get(
          Uri.parse(
              'http://172.30.1.87:5999/user/send-valid-code?email=$userEmailAddress'),
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          if (responseData['ok']) {
            print('Valid 코드 전송 성공!');

          } else {
            print('Valid 코드 전송 실패!');
          }

      }
    } catch (e) {
      print('이메일 인증 번호 전송 오류 발생: $e');
    }
  }

  Future<bool> checkValidCode(String authenticationNumber) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://172.30.1.87:5999/user/check-valid-code?email=$userEmailAddress&code=$authenticationNumber'),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['is_valid']) {
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (e) {
      print('이메일 인증 번호 검사 오류 발생: $e');
      return false;
    }
  }

  void startTimer() {
    remainingTime = 180; // 3 minutes in seconds
    _timerState = true;
    const Duration interval = Duration(seconds: 1);

    timer = Timer.periodic(interval, (Timer timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel(); // Stop the timer when it reaches 0
        print('3-minute timer expired. Implement your logic here.');
        // Add your logic here when the timer expires
      }
    });
  }

  void resetTimer() {
    setState(() {
      _timerState = false;
      timer.cancel();
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
                              });
                            },
                            validator: (value) {
                              if (value!.isNotEmpty ||
                                  _emailAddressFocus.hasFocus) {
                                _emailAddressState = true;
                              } else {
                                _emailAddressState = false;
                                return '이메일을 입력해주세요.';
                              }

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
                                  });
                                },
                                validator: (value) {
                                  if (_emailAuthenticationFocus.hasFocus) {
                                    _emailAuthenticationState = true;
                                  }
                                  if (!_emailAuthenticationState) {
                                    return '잘못된 인증번호에요.';
                                  }
                                },
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Positioned(
                              top: 21.h,
                              right: 108.w,
                              child:  Text(
                              '${remainingTime ~/ 60}:${(remainingTime % 60).toString().padLeft(2, '0')}',
                              style: TextStyle(
                                  fontFamily: 'PretendardRegular',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: _timerState ? noFocusColor : Colors.transparent),
                            ),),

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
                                onPressed: () {
                                  if (_emailAddressState) {
                                    startTimer();
                                    print('이메일 주소 : $userEmailAddress');
                                    final formKeyState =
                                    _emailAddressFormKey.currentState!;
                                    if (formKeyState.validate()) {
                                      formKeyState.save();
                                    }
                                    sendValidCode(userEmailAddress);

                                  }
                                  FocusScope.of(context)
                                      .requestFocus(_emailAuthenticationFocus);
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
                      if (_nextButtonState) {

                        _emailAuthenticationState =
                            await checkValidCode(authenticationNumber);
                        if (_emailAuthenticationState) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SetIdNamePage()));
                        }
                      }
                      setState(() {
                        final formKeyState =
                        _emailAuthenticationFormKey.currentState!;
                        if (formKeyState.validate()) {
                          formKeyState.save();
                        }
                        if (_nextButtonState && !_emailAuthenticationState) {
                          _authenticationRequestButton = true;
                          resetTimer();
                        }
                      });
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
