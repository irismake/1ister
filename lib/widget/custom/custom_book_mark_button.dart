import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBookMarkButton extends StatelessWidget {
  bool isBookMarked;
  CustomBookMarkButton({
    required this.isBookMarked,
  });

  Widget build(BuildContext context) {
    String iconName = isBookMarked ? "fill" : "empty";
    return Positioned(
      top: 4.0.h,
      right: 0.0,
      child: SizedBox(
        height: 32.0.h,
        width: 32.0.w,
        child: InkWell(
          onTap: () {
            print("북마크 상태 :$isBookMarked");
          },
          child: SvgPicture.asset(
            'assets/icons/button_book_mark_${iconName}_white.svg',
          ),
        ),
      ),
    );
  }
}
