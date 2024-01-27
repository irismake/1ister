import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tag extends StatelessWidget {
  final String tagName;
  const Tag({super.key, required this.tagName});

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
        child: Container(
          height: 18.0.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tagName,
                style: TextStyle(
                  color: Color(0xFF5BFF7F),
                  fontSize: 12.0.sp,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  height: 0.12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
