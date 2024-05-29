import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lister/model/provider/user_info_provider.dart';
import 'package:lister/page/user/user_setting_page.dart';
import 'package:provider/provider.dart';

import '../../model/provider/follows_provider.dart';
import '../../model/provider/get_lists_provider.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/navigator/page_view_navigator.dart';
import 'user_edit_info_page.dart';
import 'user_follows_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userInfoProvider =
          Provider.of<UserInfoProvider>(context, listen: false);
      userInfoProvider.fetchUserInfo();
      final followsProvider =
          Provider.of<FollowsProvider>(context, listen: false);
      followsProvider.initializeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProvider>(builder: (context, provider, child) {
      String _name = provider.userInfo.name;
      String _userName = provider.userInfo.username;
      String _profileImage = provider.userInfo.picture;
      String _bio = provider.userInfo.bio;
      return Scaffold(
        appBar: CustomAppbar(
            popState: true,
            titleText: _name,
            titleState: true,
            actionButtonOnTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserSettingPage(),
                ),
              );
            },
            actionButton: 'button_hamburger'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 24.0.h, left: 16.0.w, right: 16.0.w, bottom: 40.0.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 88.0.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _profileImage == ''
                              ? SvgPicture.asset(
                                  'assets/images/image_user_profile.svg',
                                  height: 64.0.h,
                                  width: 64.0.w,
                                )
                              : Container(
                                  color: Colors.red,
                                  height: 64.0.h,
                                  width: 64.0.w,
                                ),
                          SizedBox(
                            width: 16.0.w,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.0.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _name,
                                  style: TextStyle(
                                    color: Color(0xFF212529),
                                    fontSize: 18.sp,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w700,
                                    height: 1.5.h,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '팔로워',
                                      style: TextStyle(
                                        color: Color(0xFF868E96),
                                        fontSize: 14.sp,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 1.4.h,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 6.0.w,
                                    ),
                                    SizedBox(
                                      height: 20.0.h,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UserFollowsPage(
                                                name: _name,
                                                initialPage: 0,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Consumer<FollowsProvider>(
                                            builder:
                                                (context, provider, child) {
                                          return Text(
                                            textAlign: TextAlign.center,
                                            '${provider.usersFollowerCount}',
                                            style: TextStyle(
                                              color: Color(0xFF868E96),
                                              fontSize: 14.sp,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 24.0.w,
                                      height: 20.0.h,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/images/image_vertical_line.svg',
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '팔로잉',
                                      style: TextStyle(
                                        color: Color(0xFF868E96),
                                        fontSize: 14.sp,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 1.4.h,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 6.0.w,
                                    ),
                                    SizedBox(
                                      height: 20.0.h,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UserFollowsPage(
                                                name: _name,
                                                initialPage: 1,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Consumer<FollowsProvider>(
                                            builder:
                                                (context, provider, child) {
                                          return Text(
                                            '${provider.usersFollowingCount}',
                                            style: TextStyle(
                                              color: Color(0xFF868E96),
                                              fontSize: 14.sp,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      _bio,
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
                  ),
                  SizedBox(
                    height: 24.0.h,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserEditInfoPage(
                              userName: _userName,
                              name: _name,
                              bio: _bio,
                              picture: _profileImage,
                            ),
                          ),
                        );
                      },
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
                ],
              ),
            ),
            Expanded(
              child: PageViewNavigator(
                followState: false,
                provider: Provider.of<GetListsProvider>(context, listen: true),
                tabName_0: '나의 리스트',
                tabName_1: '북마크 리스트',
                initialPage: 0,
              ),
            ),
          ],
        ),
      );
    });
  }
}
