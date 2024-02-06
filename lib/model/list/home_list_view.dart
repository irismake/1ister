import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          child: SizedBox(
            width: 160.0,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200.0,
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF1F3F5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    Text(
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
                    Text(
                      '23.09.13',
                      style: TextStyle(
                        color: Color(0xFF868E96),
                        fontSize: 12.sp,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 1.5.h,
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 4.0.h,
                  right: 0.0,
                  child: SvgPicture.asset(
                    'assets/icons/button_book_mark.svg',
                    width: 32.0.w,
                    height: 32.0.h,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
