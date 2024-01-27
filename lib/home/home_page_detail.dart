import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lister/home/home_page.dart';
import 'package:lister/model/bottom_navigation_bar.dart';
import 'package:lister/model/custom_app_bar.dart';
import 'package:lister/model/custom_tag.dart';

class HomePageDetail extends StatefulWidget {
  HomePageDetail({Key? key}) : super(key: key);

  @override
  State<HomePageDetail> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
            titleText: '',
            titleState: false,
            actionButtonOnTap: () {},
            actionButton: null),
        body: Column(
          children: [
            Container(
              color: Colors.pink,
              height: 390.h,
              width: double.infinity,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 16.0.h, right: 16.0.h, top: 20.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 34.0.h,
                        child: const Center(
                          child: Text(
                            '후쿠오카 백화점 쇼핑 리스트',
                            style: TextStyle(
                              color: Color(0xFF343A40),
                              fontSize: 24,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              height: 0.06,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32.0.h,
                        width: 32.0.w,
                        child: InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(
                            'assets/icons/bookmark_button.svg',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22.0.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      direction: Axis.horizontal, // 나열 방향
                      alignment: WrapAlignment.start, // 정렬 방식
                      spacing: 5, // 좌우 간격
                      runSpacing: 5, // 상하 간격
                      children: [
                        Tag(tagName: '후쿠오카'),
                        Tag(tagName: '쇼핑'),
                        Tag(tagName: '백화점'),
                        Tag(tagName: '택스프리'),
                        Tag(tagName: '일본'),
                        Tag(tagName: '후쿠오카'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32.0.h,
                  ),
                  Container(
                    //color: Colors.green,
                    child: Text(
                      '후쿠오카 여행 갔을 때 가장 많이 사는 쇼핑리스트 백화점편입니다. 백화점에서는 택스프리도 받을 수 있어 할인율이 더 높아집니다.',
                      style: TextStyle(
                        color: Color(0xFF343A40),
                        fontSize: 15,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 1.3.h,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                    ),
                  ),
                  SizedBox(
                    height: 8.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '부지런한 아보카도 ',
                        style: TextStyle(
                          color: Color(0xFF868E96),
                          fontSize: 14.sp,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 1.428.h,
                        ),
                      ),
                      SizedBox(
                        width: 8.0.h,
                      ),
                      Text(
                        '23.09.13',
                        style: TextStyle(
                          color: Color(0xFF868E96),
                          fontSize: 14.sp,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 1.428.h,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0.h,
                  )
                ],
              ),
            )
          ],
        ));
  }
}
