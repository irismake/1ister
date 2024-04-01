import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBar extends StatelessWidget {
  final bool bookmarkPage;
  final String tabName;

  const CustomTabBar(
      {super.key, required this.bookmarkPage, required this.tabName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.0.h,
      width: (MediaQuery.of(context).size.width - 32.0.w) / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tabName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: bookmarkPage ? Color(0xff868E96) : Color(0xFF343A40),
              fontSize: 16.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              height: 1.5.h,
            ),
          ),
          Container(
            width: double.infinity,
            height: 2.0.h,
            decoration: BoxDecoration(
              color: bookmarkPage ? Colors.transparent : Color(0xFF212529),
            ),
          ),
        ],
      ),
    );
  }
}
