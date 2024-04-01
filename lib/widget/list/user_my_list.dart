import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../page/edit/edit_page.dart';

class UserMyList extends StatelessWidget {
  const UserMyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF8F9FA),
      child: Center(
        child: SizedBox(
          height: 100.0.h,
          // width: 165.0.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "아직 리스트가 비어있어요.",
                style: TextStyle(
                  color: Color(0xFF495057),
                  fontSize: 15.sp,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  height: 1.5.h,
                ),
              ),
              SizedBox(
                height: 52.0.h,
                width: 165.0.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Color(0xFFE9ECEF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    // textStyle: TextStyle(
                    //   color: Color(0xff212529),
                    //   fontSize: 15.sp,
                    //   fontFamily: 'Pretendard',
                    //   fontWeight: FontWeight.w700,
                    //   height: 1,
                    // ),
                    // minimumSize: Size(165.0.w, 52.0.h),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditPage()),
                    );
                  },
                  child: Text(
                    '리스트 만들기',
                    style: TextStyle(
                      color: Color(0xff212529),
                      fontSize: 15.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
