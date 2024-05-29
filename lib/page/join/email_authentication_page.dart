import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widget/custom/custom_next_page_button.dart';
import '../../widget/custom/custom_progress_bar.dart';
import '../../widget/custom/custom_text_form_field.dart';
import '../../widget/sign_widget.dart';
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

  bool _emailAddressFilled = false;
  bool _emailAddressDuplicateValid = false;
  bool _timerState = false;
  bool _emailAuthenticationFilled = false;
  bool _emailAuthenticationValid = false;
  bool _reAuthentication = false;

  FocusNode _emailAddressFocus = FocusNode();
  FocusNode _emailAuthenticationFocus = FocusNode();

  final _emailAddressFormKey = GlobalKey<FormState>();
  final _emailAuthenticationFormKey = GlobalKey<FormState>();

  String userEmailAddress = '';
  String authenticationNumber = '';

  late Timer _timer;
  int remainingTime = 180;

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

  @override
  void dispose() {
    _emailAddressFocus.dispose();
    _emailAuthenticationFocus.dispose();
    _timerState ? _timer.cancel() : null;
    super.dispose();
  }

  String? _checkEmailInput(String? value) {
    if (!_emailAddressFilled) {
      return '이메일을 입력해주세요.';
    }
  }

  String? _checkEmailDuplicate(String? value) {
    if (!_emailAddressDuplicateValid) {
      return '이미 사용중인 이메일입니다.';
    }
  }

  String? _checkAuthenticationValid(String? value) {
    if (_emailAuthenticationFocus.hasFocus) {
      _emailAuthenticationValid = true;
      return null;
    }
    if (!_emailAuthenticationValid) {
      _reAuthentication = true;
      return '잘못된 인증번호에요.';
    }
  }

  void emailAuthenticationRequest() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      _emailAuthenticationFormKey.currentState?.reset();
      FocusScope.of(context).unfocus();

      _emailAddressDuplicateValid =
          await ApiService.checkDuplicateEmail(userEmailAddress);
      if (_emailAddressDuplicateValid) {
        await ApiService.sendValidCode(userEmailAddress);
      }

      final formKeyState = _emailAddressFormKey.currentState!;
      if (formKeyState.validate()) {
        formKeyState.save();
        startTimer();
        FocusScope.of(context).requestFocus(_emailAuthenticationFocus);
      }
    } finally {
      Navigator.of(context).pop();
    }
  }

  void startTimer() {
    _timerState ? _timer.cancel() : null;
    remainingTime = 180;
    _timerState = true;

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
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
      _timerState ? _timer.cancel() : null;
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
        body: SignWidget(
          title: '회원가입을 위해\n이메일을 인증해주세요.',
          firstFieldText: '이메일 주소',
          firstCustomForm: Form(
            key: _emailAddressFormKey,
            child: CustomTextFormField(
              hintText: '이메일 주소',
              focusNode: _emailAddressFocus,
              onChanged: (value) {
                setState(() {
                  userEmailAddress = value;
                  value == ''
                      ? _emailAddressFilled = false
                      : _emailAddressFilled = true;
                });
              },
              validator: (value) {
                if (_emailAddressFocus.hasFocus) {
                  _emailAddressDuplicateValid = true;
                  return null;
                }
                List<String? Function(String)> validators = [
                  _checkEmailDuplicate,
                  _checkEmailInput
                ];
                for (var validator in validators) {
                  var result = validator(value!);
                  if (result != null) {
                    return result;
                  }
                }
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
                  authenticationNumber = value;
                  value == ''
                      ? _emailAuthenticationFilled = false
                      : _emailAuthenticationFilled = true;
                });
              },
              validator: (value) {
                return _checkAuthenticationValid(value!);
              },
              keyboardType: TextInputType.number,
            ),
          ),
          timer: Positioned(
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
          authenticationButton: Positioned(
            top: 12.h,
            right: 16.w,
            child: TextButton(
              child: Text(
                _reAuthentication ? '재인증' : '인증 요청',
                style: TextStyle(
                    fontFamily: 'PretendardRegular',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: _emailAddressFilled ? darkGrayColor : noFocusColor),
              ),
              onPressed: () {
                emailAuthenticationRequest();
              },
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
                  backgroundColor: _emailAddressFilled
                      ? focusButtonColor
                      : noFocusButtonColor),
            ),
          ),
          nextPageButton: NextPageButton(
              firstFieldState: _emailAddressFilled,
              secondFieldState: _emailAuthenticationFilled,
              text: '다음',
              onPressed: () async {
                _emailAuthenticationValid = await ApiService.checkValidCode(
                    userEmailAddress, authenticationNumber);
                resetTimer();
                final formKeyState = _emailAuthenticationFormKey.currentState!;
                if (formKeyState.validate()) {
                  formKeyState.save();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SetIdNamePage(userEmail: userEmailAddress),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
