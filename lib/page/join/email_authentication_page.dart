import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widget/custom/custom_next_page_button.dart';
import '../../widget/custom/custom_progress_bar.dart';
import '../../widget/custom/custom_text_form_field.dart';
import '../../widget/join_widget.dart';
import '../../services/api_service.dart';
import 'set_id_name_page.dart';

class EmailAuthenticationPage extends StatefulWidget {
  const EmailAuthenticationPage({Key? key}) : super(key: key);

  @override
  State<EmailAuthenticationPage> createState() =>
      _EmailAuthenticationPageState();
}

class _EmailAuthenticationPageState extends State<EmailAuthenticationPage> {
  @override
  final noFocusButtonColor = Color(0xffF9FAFB);
  final focusButtonColor = Color(0xffF1F3F5);
  final darkGrayColor = Color(0xff495057);

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
    }
    if (_emailExistState) {
      _emailExistState = false;
      return '이미 사용중인 이메일입니다.';
    }
    if (!_emailAddressState) {
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
        appBar: ProgressBar(progress: 1, totalProgress: 3),
        body: JoinWidget(
          title: '회원가입을 위해\n이메일을 인증해주세요.',
          firstFieldText: '이메일 주소',
          firstGuideState: false,
          firstGuideText: null,
          secondGuideState: false,
          secondGuideText: null,
          firstCustomForm: Form(
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
          secondFieldText: '이메일 인증',
          secondCustomForm: Form(
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
          authenticationButton: Positioned(
            top: 21.h,
            right: 108.w,
            child: Text(
              '${remainingTime ~/ 60}:${(remainingTime % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                  fontFamily: 'PretendardRegular',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: _timerState ? noFocusColor : Colors.transparent),
            ),
          ),
          authenticationState: true,
          timer: Positioned(
            top: 12.h,
            right: 16.w,
            child: TextButton(
              child: Text(
                _authenticationRequestButton ? '재인증' : '인증 요청',
                style: TextStyle(
                    fontFamily: 'PretendardRegular',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: _emailAddressState ? darkGrayColor : noFocusColor),
              ),
              onPressed: () async {
                _emailExistState =
                    await ApiService.sendValidCode(userEmailAddress);
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
                      borderRadius: BorderRadius.circular(50.0)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
                  backgroundColor: _emailAddressState
                      ? focusButtonColor
                      : noFocusButtonColor),
            ),
          ),
          nextPageButton: NextPageButton(
            firstFieldState: _emailAddressState,
            secondFieldState: _emailAuthenticationState,
            text: '다음',
            onPressed: () async {
              _checkAuthenticationState = await ApiService.checkValidCode(
                  userEmailAddress, authenticationNumber);
              setState(
                () {
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
                            builder: (context) =>
                                SetIdNamePage(userEmail: userEmailAddress),
                          ),
                        );
                      }
                    }
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
