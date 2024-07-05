import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/custom_ui_kit/custom_next_page_button.dart';
import '../login/login_page.dart';

class SignUpCongratulationPage extends StatefulWidget {
  SignUpCongratulationPage({Key? key}) : super(key: key);

  @override
  State<SignUpCongratulationPage> createState() =>
      _SignUpCongratulationPageState();
}

class _SignUpCongratulationPageState extends State<SignUpCongratulationPage> {
  late Timer _timer;
  int _remainingSeconds = 3;

  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _navigateToHomePage();
      }
    });
  }

  void _navigateToHomePage() {
    _timer.cancel();
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 40.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 74.0.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '리스터가 된 걸 축하해요!\n'
                  '나만의 리스트를 만들어봐요.',
                  style: TextStyle(
                    fontFamily: 'PretendardRegular',
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    height: 1.43,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.0.h),
            Expanded(
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/image_welcome.svg',
                  width: 358.w, // Ensure the SVG has a width constraint
                ),
              ),
            ),
            NextPageButton(
              firstFieldState: true,
              secondFieldState: true,
              text: '$_remainingSeconds초 후에 메인으로 이동해요',
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
