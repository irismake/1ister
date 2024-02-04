import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookMarkListWidget extends StatelessWidget {
  //final Widget page;
  final int index;

  const BookMarkListWidget({Key? key, required this.index}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 218.0.h,
          decoration: ShapeDecoration(
            color: Color(0xFFF1F3F5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        SizedBox(
          height: 12.0.h,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '모든 List (54)',
            style: TextStyle(
              color: Color(0xFF343A40),
              fontSize: 14.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              height: 1.4.h,
            ),
          ),
        ),
      ],
    );
  }
}
