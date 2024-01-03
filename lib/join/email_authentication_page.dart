import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailAuthenticationPage extends StatefulWidget {
  const EmailAuthenticationPage({Key? key}) : super(key: key);

  @override
  State<EmailAuthenticationPage> createState() =>
      _EmailAuthenticationScreenState();
}

class _EmailAuthenticationScreenState extends State<EmailAuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, child) => MaterialApp(
        title: 'Flutter Demo',
        home: _EmailAuthenticationWidget(),
        debugShowCheckedModeBanner: false,
      ),
      designSize: const Size(390, 844),

      //minTextAdapt: true, // 텍스트 크기를 자동으로 조정하여 화면에 맞추는 기능을 활성화
      splitScreenMode: true,
    );
  }
}

class _EmailAuthenticationWidget extends StatefulWidget {
  const _EmailAuthenticationWidget({super.key});

  @override
  State<_EmailAuthenticationWidget> createState() =>
      EmailAuthenticationWidget();
}

class EmailAuthenticationWidget extends State<_EmailAuthenticationWidget> {
  final noFocusColor = Color(0xffCED4DA);
  final noFocusTextColor = Color(0xff868E96);
  final brandPointColor = Color(0xff5BFF7F);
  final darkGrayColor = Color(0xff495057);
  final errorColor = Color(0xffFA5252);
  final noFocusButtonColor = Color(0xffF9FAFB);
  final focusButtonColor = Color(0xffF1F3F5);

  bool _nextButtonState = false;
  bool _emailAddressState = false;
  bool _emailAuthenticationState = false;

  FocusNode _emailAddressFocus = FocusNode();
  FocusNode _emailAuthenticationFocus = FocusNode();

  final _emailAddressFormKey = GlobalKey<FormState>();
  final _emailAuthenticationFormKey = GlobalKey<FormState>();

  String userEmailAddress = '';
  String authenticationNumber = '';

  @override
  void initState() {
    super.initState();

    _emailAddressFocus.addListener(() {
      setState(() {

        final formKeyState = _emailAddressFormKey.currentState!;
        if (formKeyState.validate()) {
          formKeyState.save();
        }

        if (_emailAddressState && _emailAuthenticationState){
          _nextButtonState = true;
        }else{
          _nextButtonState =false;
        }
      });
    });

    _emailAuthenticationFocus.addListener(() {
      setState(() {

        if (_emailAddressState && _emailAuthenticationState){
          _nextButtonState = true;
        }else{
          _nextButtonState = false;
        }
      });
    });
  }

  Future<void> sendValidCode(String userEmailAddress) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://172.30.1.87:5999/user/send-valid-code?email=$userEmailAddress'),
      );

      if (response.statusCode == 200) {
        print(response.body);
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

  Future<void> checkValidCode(String authenticationNumber) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://172.30.1.87:5999/user/check-valid-code?email=$userEmailAddress&code=$authenticationNumber'),
      );

      if (response.statusCode == 200) {
        print(response.body);
        final responseData = json.decode(response.body);

        if (responseData['is_valid']) {
          _emailAuthenticationState = true;
          print('Valid 코드 유효성 검사 성공!');
        } else {
          _emailAuthenticationState = false;
          print('Valid 코드 유효성 검사 실패!');
        }
      } else {}
    } catch (e) {
      print('이메일 인증 번호 검사 오류 발생: $e');
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
                      //color : Colors.green,
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
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          child: TextFormField(

                            onChanged: (value) {
                              setState(() {
                                userEmailAddress = value!;
                                print('이메일 주소 : $userEmailAddress');


                              });
                            },
                            validator: (value) {
                              if (_emailAddressFocus.hasFocus) {
                                _emailAddressState = true;
                              }

                              if(value!.isEmpty && !_emailAddressFocus.hasFocus){
                                _emailAddressState = false;
                              }

                              if (!_emailAddressState) {

                                return '이메일을 입력해주세요.';
                              } else {

                                return null;
                              }
                            },
                            style: TextStyle(
                              fontFamily: 'PretendardRegular',
                              decorationThickness: 0,
                              fontSize: 16.sp,
                              color: _emailAddressFocus.hasFocus
                                  ? Colors.black
                                  : noFocusTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                            showCursor: false,
                            focusNode: _emailAddressFocus,
                            decoration: InputDecoration(
                              isDense: true,
                              prefix: Container(width: 16.w),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 20.0.h),
                              hintText: "이메일 주소",
                              hintStyle: TextStyle(
                                fontFamily: 'PretendardRegular',
                                color: noFocusColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                    width: 1.w, color: brandPointColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1.w, color: noFocusColor),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1.w, color: errorColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1.w, color: errorColor),
                              ),
                              errorStyle: TextStyle(
                                fontFamily: 'PretendardRegular',
                                color: errorColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    if(value!.isNotEmpty){
                                      print("true");
                                      _emailAuthenticationState = true;
                                    }else{
                                      _emailAuthenticationState = false;
                                    }
                                    authenticationNumber = value!;
                                    print('인증 코드 : $authenticationNumber');
                                  });
                                },
                                validator: (value) {



                                  if(_emailAuthenticationState){
                                    return null;
                                  }else{
                                    return '잘못된 인증번호에요.';
                                  }

                                },
                                style: TextStyle(
                                  fontFamily: 'PretendardRegular',
                                  decorationThickness: 0,
                                  fontSize: 16.sp,
                                  color: _emailAuthenticationFocus.hasFocus
                                      ? Colors.black
                                      : noFocusTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                showCursor: false,
                                focusNode: _emailAuthenticationFocus,
                                decoration: InputDecoration(
                                  isDense: true,
                                  prefix: Container(width: 16.w),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 20.h),
                                  hintText: "인증 번호",
                                  hintStyle: TextStyle(
                                    fontFamily: 'PretendardRegular',
                                    //decorationThickness: 0,
                                    color: noFocusColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1.w, color: brandPointColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1.w, color: noFocusColor),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1.w, color: errorColor),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1.w, color: errorColor),
                                  ),
                                  errorStyle: TextStyle(
                                    fontFamily: 'PretendardRegular',
                                    color: errorColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1.w, color: noFocusColor),
                                  ),
                                ),
                                //enabled: _emailAuthenticationState,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16.w, top: 0),
                              child: TextButton(
                                child: Text(
                                  '인증 요청',
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
                                    print(userEmailAddress);
                                    sendValidCode(userEmailAddress);
                                  }
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
                    onPressed: () {
                      checkValidCode(authenticationNumber);
                      final formKeyState = _emailAuthenticationFormKey.currentState!;
                      if (formKeyState.validate()) {
                        formKeyState.save();
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
