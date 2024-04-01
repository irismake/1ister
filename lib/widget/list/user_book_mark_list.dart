import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserBookMarkList extends StatelessWidget {
  const UserBookMarkList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF8F9FA),
      child: Center(
        child: Text(
          "아직 북마크 리스트가 비어있어요.",
          style: TextStyle(
            color: Color(0xff495057),
            fontSize: 16.sp,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            height: 1.5.h,
          ),
        ),
      ),
    );
  }
}
