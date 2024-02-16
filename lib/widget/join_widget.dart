import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom/custom_next_page_button.dart';

class JoinWidget extends StatelessWidget {
  final String title;
  final String firstFieldText;
  final String secondFieldText;
  final NextPageButton nextPageButton;
  final bool firstGuideState;
  final String? firstGuideText;
  final bool secondGuideState;
  final String? secondGuideText;
  final Form firstCustomForm;
  final Form secondCustomForm;
  final bool authenticationState;
  final Widget? authenticationButton;
  final Widget? timer;

  JoinWidget({
    required this.title,
    required this.firstFieldText,
    required this.secondFieldText,
    required this.nextPageButton,
    required this.firstGuideState,
    required this.firstGuideText,
    required this.secondGuideState,
    required this.secondGuideText,
    required this.firstCustomForm,
    required this.secondCustomForm,
    required this.authenticationState,
    required this.authenticationButton,
    required this.timer,
  });

  final noFocusColor = Color(0xffCED4DA);
  final darkGrayColor = Color(0xff495057);
  final mildGrayColor = Color(0xffADB5BD);
  final noFocusButtonColor = Color(0xffF9FAFB);
  final focusButtonColor = Color(0xffF1F3F5);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 70.0.h),
            child: Column(
              children: [
                Container(
                  height: 80.h,
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    child: Text(
                      title,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            firstFieldText,
                            style: TextStyle(
                              fontFamily: 'PretendardRegular',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: darkGrayColor,
                            ),
                          ),
                        ),
                        if (firstGuideState)
                          Text(
                            firstGuideText!,
                            style: TextStyle(
                              fontFamily: 'PretendardRegular',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: mildGrayColor,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    firstCustomForm,
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            secondFieldText,
                            style: TextStyle(
                              fontFamily: 'PretendardRegular',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: darkGrayColor,
                            ),
                          ),
                        ),
                        if (secondGuideState)
                          Text(
                            secondGuideText!,
                            style: TextStyle(
                              fontFamily: 'PretendardRegular',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: mildGrayColor,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    // Conditionally render stack

                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        secondCustomForm,
                        if (authenticationState)
                          authenticationButton ??
                              SizedBox(), // Use SizedBox() or another default widget if null
                        timer ?? SizedBox(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40.0.h),
            child: nextPageButton,
          ),
        ],
      ),
    );
  }
}
