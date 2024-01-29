import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeyWord extends StatelessWidget {
  final String keyWordName;
  const KeyWord({super.key, required this.keyWordName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Color(0xFF212529),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 3.0.h),
        child: Text(
          keyWordName,
          style: TextStyle(
            color: Color(0xFF5BFF7F),
            fontSize: 12.0.sp,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
