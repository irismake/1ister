import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeListView extends StatelessWidget {
  HomeListView({super.key});

  final List<String> entries = <String>['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: entries.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: 12.0.w),
          child: Container(
            height: 72.0.h,
            width: 160.0.w,
            // color: Colors.yellow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200.0.h,
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF1F3F5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0.h),
                  child: Text(
                    '리뷰 4.5점 이상 서울 돈카츠 맛집 리스트',
                    style: TextStyle(
                      color: Color(0xFF343A40),
                      fontSize: 16.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 1.5.h,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Text(
                  '23.09.13',
                  style: TextStyle(
                    color: Color(0xFF868E96),
                    fontSize: 12,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
