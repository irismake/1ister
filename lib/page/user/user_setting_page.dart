import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lister/services/api_service.dart';
import 'package:restart_app/restart_app.dart';

import '../../widget/custom/custom_next_page_button.dart';
import '../../widget/custom_app_bar.dart';

class UserSettingPage extends StatelessWidget {
  UserSettingPage({super.key});

  List<String> settingCategory = ['공지사항', '도움말', '문의하기', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          popState: true,
          titleText: '설정',
          titleState: true,
          actionButtonOnTap: () {},
          actionButton: 'button_hamburger'),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0.h, horizontal: 16.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 68.0.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          settingCategory[index],
                          style: TextStyle(
                            color: Color(0xff212529),
                            fontSize: 18.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                            height: 1.5.h,
                          ),
                        ),
                      ],
                    ),
                  );
                  ;
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Color(0xffDEE2E6),
                    thickness: 1,
                    height: 0,
                  );
                },
              ),
            ),
            NextPageButton(
              firstFieldState: true,
              secondFieldState: true,
              text: '계정 탈퇴',
              onPressed: () async {
                await ApiService.leaveUser();
                Future.delayed(
                  const Duration(milliseconds: 500),
                  () {
                    Restart.restartApp();
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
