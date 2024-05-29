import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom/custom_next_page_button.dart';

class SignWidget extends StatelessWidget {
  final String title;
  final String? firstFieldText;
  final String? secondFieldText;
  final NextPageButton nextPageButton;
  final String? firstGuideText;
  final String? secondGuideText;
  final Form firstCustomForm;
  final Form secondCustomForm;
  final Widget? authenticationButton;
  final Widget? timer;

  SignWidget({
    required this.title,
    this.firstFieldText,
    this.secondFieldText,
    required this.nextPageButton,
    this.firstGuideText,
    this.secondGuideText,
    required this.firstCustomForm,
    required this.secondCustomForm,
    this.authenticationButton,
    this.timer,
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
                          height: 1.4.h),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.h,
                ),
                Column(
                  children: [
                    firstFieldText != null
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      firstFieldText!,
                                      style: TextStyle(
                                          fontFamily: 'PretendardRegular',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: darkGrayColor,
                                          height: 1.4.h),
                                    ),
                                  ),
                                  Text(
                                    firstGuideText ?? '',
                                    style: TextStyle(
                                      fontFamily: 'PretendardRegular',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: mildGrayColor,
                                      height: 1.5.h,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    firstCustomForm,
                    SizedBox(
                      height: 12.h,
                    ),
                    secondFieldText != null
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      secondFieldText!,
                                      style: TextStyle(
                                        fontFamily: 'PretendardRegular',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: darkGrayColor,
                                        height: 1.4.h,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    secondGuideText ?? '',
                                    style: TextStyle(
                                      fontFamily: 'PretendardRegular',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: mildGrayColor,
                                      height: 1.5.h,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        secondCustomForm,
                        authenticationButton ?? SizedBox(),
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
