import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lister/model/custom_keyword.dart';

class ListWidget extends StatelessWidget {
  final String searchWord;

  const ListWidget({super.key, required this.searchWord});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.deepOrange,
      width: double.infinity,
      height: 154.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 88.0,
                height: 110.0,
                decoration: ShapeDecoration(
                  color: Color(0xFFF1F3F5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '후쿠오카',
                      style: TextStyle(
                        color: Color(0xFF343A40),
                        fontSize: 18.sp,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 1.5.h,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6.0, bottom: 16.0),
                      child: KeyWord(keyWordName: '키워드'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '부지런한 아보카도',
                          style: TextStyle(
                            color: Color(0xFF868E96),
                            fontSize: 12.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(
                          width: 8.0.w,
                        ),
                        Text(
                          '23.09.13',
                          style: TextStyle(
                            color: Color(0xFF868E96),
                            fontSize: 12.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/button_book_mark.svg',
              width: 32.0,
              height: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}
