import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../custom/custom_next_page_button.dart';

class AgreementPopUp extends StatelessWidget {
  final VoidCallback onAgree;
  AgreementPopUp({Key? key, required this.onAgree}) : super(key: key);

  bool _isChecked_A = false;
  bool _isChecked_B = false;
  bool _isChecked_C = false;

  final checkTextColor = Color(0xff868E96);
  final darkGrayColor = Color(0xff495057);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            color: Colors.white,
          ),
          height: 280.h,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 160.h,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 32.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '시작하기 전, 이용약관에 동의해주세요.',
                              style: TextStyle(
                                  fontFamily: 'PretendardRegular',
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            InkWell(
                              child: SizedBox(
                                height: 32.0.h,
                                child: SvgPicture.asset(
                                  'assets/icons/icon_close_black.svg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      CustomCheckbox(
                        checkState: _isChecked_A,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked_A = value!;
                            _isChecked_B = value;
                            _isChecked_C = value;
                          });
                        },
                        textStyle: Text(
                          "리스터의 모든 약관을 확인했고 동의해요.",
                          style: TextStyle(
                              fontFamily: 'PretendardRegular',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: darkGrayColor),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomCheckbox(
                        checkState: _isChecked_B,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked_B = value!;
                          });
                        },
                        textStyle: Text(
                          "(필수) 이용약관에 동의해요.",
                          style: TextStyle(
                              fontFamily: 'PretendardRegular',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: checkTextColor),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      CustomCheckbox(
                        checkState: _isChecked_C,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked_C = value!;
                          });
                        },
                        textStyle: Text(
                          "(필수) 개인정보 수집 및 이용에 동의해요.",
                          style: TextStyle(
                              fontFamily: 'PretendardRegular',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: checkTextColor),
                        ),
                      ),
                    ],
                  ),
                ),
                NextPageButton(
                  firstFieldState: true,
                  secondFieldState: true,
                  text: '회원가입',
                  onPressed: () async {
                    if (_isChecked_A && _isChecked_B && _isChecked_C) {
                      Navigator.pop(context);
                      onAgree();
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool checkState;
  final ValueChanged<bool?> onChanged;
  final Text textStyle;

  CustomCheckbox({
    required this.checkState,
    required this.onChanged,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Transform.scale(
            scale: 2.5,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Checkbox(
                value: checkState,
                onChanged: onChanged,
                activeColor: Color.fromARGB(255, 22, 33, 45),
                checkColor: Colors.white,
                hoverColor: Colors.black,
                side: BorderSide(width: 1.sp, color: Color(0xffCED4DA)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.0.w),
          textStyle,
        ],
      ),
    );
  }
}
