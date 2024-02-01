import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lister/page/list_detail_page.dart';
import 'package:lister/model/home_page_navigator.dart';
import 'package:lister/model/custom_app_bar.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          titleText: '부지런한 아보카도',
          titleState: true,
          actionButtonOnTap: () {},
          actionButton: 'button_hamburger'),
      body: Padding(
        padding: EdgeInsets.only(
            top: 24.0.h, left: 16.0.w, right: 16.0.w, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0.h),
              child: Container(
                color: Colors.teal,
                height: 64.0.h,
              ),
            ),
            SizedBox(
              height: 8.0.h,
            ),
            Text(
              '저는 부지런한 아보카도에요. 너무 빨리 익어서 아직 딱딱해서 먹을수는 없어요. 저는 맛집을 좋아해요.',
              style: TextStyle(
                color: Color(0xFF868E96),
                fontSize: 14.sp,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                height: 1.4.h,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            SizedBox(
              height: 24.0.h,
            ),
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8.0.h),
                  backgroundColor: Color(0xffF1F3F5),
                ),
                child: Text(
                  '계정 편집',
                  style: TextStyle(
                    color: Color(0xFF495057),
                    fontSize: 14.sp,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    height: 1.4.h,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0.h,
            ),
            Container(
              color: Colors.orange,
              height: 58.0.h,
            )
          ],
        ),
      ),
    );
  }
}
