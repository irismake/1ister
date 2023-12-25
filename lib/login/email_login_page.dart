import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({Key? key}) : super(key: key);

  @override
  State<EmailLoginPage> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, child) => MaterialApp(
        title: 'Flutter Demo',
        home: _EmailLoginWidget(),
        debugShowCheckedModeBanner: false,
      ),
      designSize: const Size(390, 844),

      //minTextAdapt: true, // 텍스트 크기를 자동으로 조정하여 화면에 맞추는 기능을 활성화
      splitScreenMode: true,
    );
  }
}

class _EmailLoginWidget extends StatefulWidget {
  const _EmailLoginWidget({super.key});

  @override
  State<_EmailLoginWidget> createState() => EmailLoginWidget();
}

class EmailLoginWidget extends State<_EmailLoginWidget> {
  final noFocusColor = Color(0xffCED4DA);
  final noFocusTextColor = Color(0xff868E96);
  final brandPointColor = Color(0xff5BFF7F);

  Color _emailTextColor = Colors.black;
  Color _passwordTextColor = Colors.black;

  String inputEmail = '';
  String inputPassword = '';
  String finalEmail = '';
  String finalPassword = '';

  bool _emailState = false;
  bool _passwordState = false;
  bool _loginButtonState = false;

  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();

  TextEditingController _inputEmailController = TextEditingController();
  TextEditingController _inputPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _inputEmailController.addListener(() {
      setState(() {
        if (_inputEmailController.text.isNotEmpty) {
          _emailState = true;
          if (_passwordState == true) {
            _loginButtonState = true;
          }
        } else {
          _emailState = false;
          _loginButtonState = false;
        }
      });
    });

    _inputPasswordController.addListener(() {
      setState(() {
        if (_inputPasswordController.text.isNotEmpty) {
          _passwordState = true;
          if (_emailState == true) {
            _loginButtonState = true;
          }
        } else {
          _passwordState = false;
          _loginButtonState = false;
        }
      });
    });

    _emailFocus.addListener(() {
      setState(() {
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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w,  vertical: 0.0),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 128.h),
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
                          TextField(
                            style: TextStyle(
                              fontFamily: 'PretendardRegular',
                              decorationThickness: 0,
                              fontSize: ScreenUtil().setSp(16),
                              color: _emailTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                            showCursor: false,
                            controller: _inputEmailController,
                            focusNode: _emailFocus,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0.h, horizontal: 16.w),
                              hintText: '이메일',
                              hintStyle: TextStyle(
                                fontFamily: 'PretendardRegular',
                                color: noFocusColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              labelStyle: TextStyle(color: brandPointColor),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                BorderSide(width: 1.w, color: brandPointColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                BorderSide(width: 1.w, color: noFocusColor),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          TextField(
                            style: TextStyle(
                              fontFamily: 'PretendardRegular',
                              decorationThickness: 0,
                              fontSize: 16.sp,
                              color: _passwordTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.start,
                            controller: _inputPasswordController,
                            focusNode: _passwordFocus,
                            showCursor: false,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.0.w, vertical: 20.h),
                              hintText: '비밀번호',
                              hintStyle: TextStyle(
                                decorationThickness: 0,
                                color: noFocusColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              labelStyle: TextStyle(color: brandPointColor),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                BorderSide(width: 1.w, color: brandPointColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                BorderSide(width: 1.w, color: noFocusColor),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                        ],
                      ),

                    ],
                  ),

                ),

                Padding(
                  padding: EdgeInsets.only(bottom:40.h),
                  child:
                  TextButton(
                    onPressed: () {
                      setState(() {
                        finalEmail = _inputEmailController.text;
                        finalPassword = _inputPasswordController.text;
                        print("[final email] : $finalEmail");
                        print("[final password] : $finalPassword");
                      });
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 158.w, vertical: 20.h),
                      backgroundColor:
                          _loginButtonState ? Colors.black : noFocusColor,
                    ),
                    child: Text(
                      "로그인",
                      style: TextStyle(
                        fontFamily: 'PretendardRegular',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: _loginButtonState ? brandPointColor : Colors.white,
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
