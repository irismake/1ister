
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
        // final formKeyState = _emailAddressFormKey.currentState;
        // if (formKeyState != null && formKeyState.validate()) {
        //   formKeyState.save();
        // }
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
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty &&
                                  !_emailAddressFocus.hasFocus) {
                                _emailAddressState = false;
                                _emailAuthenticationState = false;
                                return '이메일을 입력해주세요.';
                              } else {
                                _emailAddressState = true;
                                _emailAuthenticationState = true;
                                return null;

                                // if (value!.isNotEmpty && _emailAddressFocus.hasFocus){
                                //   _emailAddressState = true;
                                //   _emailAuthenticationState = true;
                                // }else{
                                //   return '이메일을 입력해주세요.';
                                //   _emailAuthenticationState = false;
                              }
                            },
                            style: TextStyle(
                              fontFamily: 'PretendardRegular',
                              decorationThickness: 0,
                              fontSize: 16.sp,
                              color: _emailAddressFocus.hasFocus ? Colors.black : noFocusTextColor,
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
                                  setState(() {});
                                },
                                validator: (value) {
                                  // if (value!.isNotEmpty) {
                                  //   _emailAuthenticationState = true;
                                  //   return null;
                                  // } else {
                                  //   _emailAuthenticationState = false;
                                  //   return '잘못된 인증번호에요.';
                                  // }
                                  setState(() {
                                    if (value!.isNotEmpty &&
                                        _emailAddressState) {
                                      _nextButtonState = true;
                                    } else {
                                      _nextButtonState = false;
                                    }
                                  });
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
                                  // Give container some width.
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 20.h),
                                  hintText: "인증 번호",
                                  hintStyle: TextStyle(
                                    fontFamily: 'PretendardRegular',
                                    decorationThickness: 0,
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
                                enabled: _emailAuthenticationState,
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
                                    // _emailAuthenticationState = true;
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
                      setState(() {
                        final formKeyState = _emailAddressFormKey.currentState!;
                        if (formKeyState.validate()) {
                          formKeyState.save();
                        }
                        // final kk = _emailAuthenticationFormKey.currentState!;
                        // if (kk.validate()) {
                        //   kk.save();
                        // }
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
