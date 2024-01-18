import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 176.0.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '궁금한 리스트를\n검색해보세요.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28.0.sp,
                      ),
                    ),
                  ),
                  Container(
                    height: 48.0.h,
                    decoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(8.0)),
                      color: Color(0xffF5F6F7),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              //color: Colors.green,
              height: 352.0.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 42.0.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '지금 핫한 리스트',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0.sp,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                print('더보기');
                              },
                              child: Text(
                                '더보기',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0.sp,
                                  color: Color(0xff868E96),
                                ),
                              ),
                            )

                            // Text(
                            //   '지금 핫한 리스트',
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.w700,
                            //     fontSize: 18.0.sp,
                            //   ),
                            // ),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                          height: 2.0.h,
                          thickness: 2.0.h,

                          // indent: 0,
                          // endIndent: 0,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.pink,
                    height: 282.0.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      );
  }
}