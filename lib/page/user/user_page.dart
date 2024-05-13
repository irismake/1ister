import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lister/model/provider/user_info_provider.dart';
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
  String userName = '';
  String name = '';
  String bio = '';
  String profileImage = '';

  int followingCount = 0;
  int followerCount = 0;

  @override
  initState() {
    super.initState();
    initializeFollows();
    initializeUserInfo();
  }

  Future<void> initializeFollows() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final followsProvider =
          Provider.of<FollowsProvider>(context, listen: false);
      followsProvider.initializeData().then((_) {
        followingCount = followsProvider.usersFollowingCount;
        followerCount = followsProvider.usersFollowerCount;
      });
    });
  }

  Future<void> initializeUserInfo() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userInfoProvider =
          Provider.of<UserInfoProvider>(context, listen: false);
      userInfoProvider.fetchUserInfo().then((_) {
        userName = userInfoProvider.userInfo.username;
        name = userInfoProvider.userInfo.name;
        //picture = userInfoProvider.userInfo.picture;
        bio = userInfoProvider.userInfo.bio;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: CustomAppbar(
            popState: true,
            titleText: name,
            titleState: true,
            actionButtonOnTap: () {},
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
                          profileImage == ''
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
                                  name,
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
                                                name: name,
                                                initialPage: 0,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          '$followerCount',
                                          style: TextStyle(
                                            color: Color(0xFF868E96),
                                            fontSize: 14.sp,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
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
                                                name: name,
                                                initialPage: 1,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          '$followingCount',
                                          style: TextStyle(
                                            color: Color(0xFF868E96),
                                            fontSize: 14.sp,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
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
                      bio,
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
                              userName: userName,
                              name: name,
                              bio: bio,
                              picture: profileImage,
                            ),
                          ),
                        ).then((value) {
                          initializeUserInfo();
                        });
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
