import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../login/login_page.dart';
import '../main.dart';
import '../model/next_page_button.dart';

class SignUpCongratulationPage extends StatelessWidget {
  SignUpCongratulationPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 74.0.h),
                  child: Container(
                    height: 80.h,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '리스터가 된 걸 축하해요!\n'
                      '나만의 리스트를 만들어봐요.',
                      style: TextStyle(
                        fontFamily: 'PretendardRegular',
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 40.0.h,
                // ),
                SizedBox(
                  height: 40.0.h,
                ),
                SizedBox(
                  height: 358.h,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: SvgPicture.asset(
                      'assets/images/welcome.svg',
                      width: 115.2.w,
                      height: 32.h,
                    ),
                  ),
                ),
              ],
            ),
            NextPageButton(
              firstFieldState: true,
              secondFieldState: true,
              text: '3초 후에 메인으로 이동해요',
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);

                // Navigator.of(context).pushAndRemoveUntil(
                //     CupertinoPageRoute(builder: (context) => MyHomePage()), (
                //     route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
