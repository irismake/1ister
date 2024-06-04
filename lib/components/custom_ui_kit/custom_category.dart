import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Category extends StatelessWidget {
  final String categoryName;
  final bool categoryState;
  const Category(
      {super.key, required this.categoryName, required this.categoryState});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.0.w,
      height: 32.0.h,
      decoration: ShapeDecoration(
        color: categoryState ? Color(0xFF212529) : Color(0xFFCED4DA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 6.0.h),
        child: Center(
          child: Text(
            categoryName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              height: 0.10,
            ),
          ),
        ),
      ),
    );
  }
}
