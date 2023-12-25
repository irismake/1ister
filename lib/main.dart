import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'join/email_authentication_page.dart';
import 'login/email_login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, child) => MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
      designSize: const Size(390, 844),

      minTextAdapt: true, // 텍스트 크기를 자동으로 조정하여 화면에 맞추는 기능을 활성화
      splitScreenMode: true,
    );
  }
}

class MyHomePage extends StatelessWidget {
  final grayColor = Color(0xff212529);
  final mildGrayColor = Color(0xff868E96);

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 256.h),
              child: Container(
                height: 84.h,
                //color: Colors.purple,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/images/Logo_Name.svg',
                      width: 115.2.w,
                      height: 32.h,
                    ),
                    // SizedBox(
                    //   height: 24.h,
                    // ),
                    Text(
                      "나만의 리스트 관리 플랫폼 리스터",
                      style: TextStyle(
                        fontFamily: 'PretendardRegular',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom:40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 97.5.w, vertical: 20.h),
                      backgroundColor: grayColor,
                    ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/Google_Icon.png',
                            width: 18.w,
                            height: 18.33.h,
                          ),
                          Text(
                            "구글 계정으로 로그인",

                            style: TextStyle(
                             fontFamily: 'PretendardRegular',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(
                    height: 12.h,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const EmailLoginPage()));
                    },
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 1.0, color: grayColor),
                        padding: EdgeInsets.symmetric(
                            horizontal: 128.5.w, vertical: 20.h),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)))),
                    child:FittedBox(
                        child: Text(
                          "이메일로 로그인",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'PretendardRegular',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: grayColor,
                          ),
                        ),
                      ),
                    ),

                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 20.h,
                    width: 135.w,

                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const EmailAuthenticationPage()));
                        },
                        style: TextButton.styleFrom(
                         padding: EdgeInsets.symmetric(vertical: 0.1.h)
                        ),
                        child: FittedBox(
                          child: Text(
                            "아직 회원이 아니신가요?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'PretendardRegular',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: mildGrayColor,
                            ),
                          ),
                        ),
                      ),
                    ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
