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
      builder: (BuildContext context, child) =>
          MaterialApp(
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
  final noFocusButtonColor = Color(0xffF1F3F5);


  Color _emailTextColor = Colors.black;
  Color _passwordTextColor = Colors.black;

  String inputEmail = '';
  String inputPassword = '';
  String finalEmail = '';
  String finalPassword = '';

  bool _loginButtonState = false;
  bool emailValidateState = false;

  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();

  final _emailFormKey = GlobalKey<FormState>();
  final _certificationFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _emailFocus.addListener(() {
      setState(() {
        // final formKeyState = _emailFormKey.currentState;
        // if (formKeyState != null && formKeyState.validate()) {
        //   formKeyState.save();
        // }
        final formKeyState = _emailFormKey.currentState!;
        if (formKeyState.validate()) {
          formKeyState.save();
        }
        _emailTextColor =
        _emailFocus.hasFocus ? Colors.black : noFocusTextColor;
      });
    });

    _passwordFocus.addListener(() {
      setState(() {
        _passwordTextColor =
        _passwordFocus.hasFocus ? Colors.black : noFocusTextColor;
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
                          key: _emailFormKey,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty && !_emailFocus.hasFocus) {
                                emailValidateState = true;
                                return '이메일을 입력해주세요.';
                              } else {
                                emailValidateState = false;
                                return null;
                              }
                            },
                            style: TextStyle(
                              fontFamily: 'PretendardRegular',
                              decorationThickness: 0,
                              fontSize: 16.sp,
                              color: _emailTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                            showCursor: false,
                            focusNode: _emailFocus,
                            decoration: InputDecoration(
                              isDense: true,
                              prefix: Container(width: 16.w),
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 20.0.h),
                              hintText: emailValidateState ? null : "이메일 주소",
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
                              key: _certificationFormKey,
                              child: TextFormField(
                                validator: (value) {},
                                style: TextStyle(
                                  fontFamily: 'PretendardRegular',
                                  decorationThickness: 0,
                                  fontSize: 16.sp,
                                  color: _passwordTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                showCursor: false,
                                focusNode: _passwordFocus,
                                decoration: InputDecoration(
                                  isDense: true,
                                  prefix: Container(width: 16.w),
                                  // Give container some width.
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 20.h),
                                  hintText: '인증번호',
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
                                    borderSide:
                                    BorderSide(width: 1.w, color: noFocusColor),
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
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Padding(
                             padding: EdgeInsets.only(right: 16.w, top: 0),
                              child: TextButton(
                                child:Text('인증 요청',
                                  style: TextStyle(
                                  fontFamily: 'PretendardRegular',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color:
                                  noFocusColor
                                ),),

                                onPressed: () {
                                  setState(() {

                                  });
                                },
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 9.h),
                                  backgroundColor:
                                  noFocusButtonColor,
                                ),
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
                      final formKeyState = _emailFormKey.currentState!;
                      if (formKeyState.validate()) {
                        formKeyState.save();
                      }
                      setState(() {});
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
                      "다음",
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
