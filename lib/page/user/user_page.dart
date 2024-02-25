import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../services/api_service.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/navigator/user_list_navigator.dart';
import 'user_edit_info_page.dart';
import 'user_follows_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _myListState = true;
  bool homePageState = false;
  bool _isLoading = true;

  late String userName = '';
  late String name = '';
  late String bio = '';
  late String profileImage = '';
  late int followingNum = 0;
  late int followerNum = 0;
  late List<dynamic> userFollowersInfo;
  late List<dynamic> userFollowingsInfo;

  @override
  initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    final userInfo = await ApiService.getUserInfo();
    final userFollows = await ApiService.getUserFollows();
    setState(() {
      userName = utf8.decode(userInfo['username'].toString().codeUnits);
      name = utf8.decode(userInfo['name'].toString().codeUnits);
      bio = utf8.decode(userInfo['bio'].toString().codeUnits);
      profileImage = utf8.decode(userInfo['picture'].toString().codeUnits);
      _isLoading = false;
      followingNum = userFollows['following_count'];
      followerNum = userFollows['follower_count'];
      userFollowersInfo = userFollows['followers'];
      userFollowingsInfo = userFollows['followings'];
      print(userFollowersInfo);
      print(userFollowingsInfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          titleText: name,
          titleState: true,
          actionButtonOnTap: () {},
          actionButton: 'button_hamburger'),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 24.0.h, left: 16.0.w, right: 16.0.w, bottom: 20.0.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                                    followState: true,
                                                    followsInfo:
                                                        userFollowersInfo,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              '$followerNum',
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
                                                    followState: false,
                                                    followsInfo:
                                                        userFollowingsInfo,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              '$followingNum',
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
                                )).then((value) {
                              if (value) {
                                getUserInfo();
                              }
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
                      SizedBox(
                        height: 40.0.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _myListState = true;
                              });
                            },
                            child: Container(
                              height: 38.0.h,
                              width:
                                  (MediaQuery.of(context).size.width - 32.0.w) /
                                      2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '나의 리스트',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _myListState
                                          ? Color(0xFF343A40)
                                          : Color(0xff868E96),
                                      fontSize: 16.sp,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w600,
                                      height: 1.5.h,
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 2.0.h,
                                    decoration: BoxDecoration(
                                        color: _myListState
                                            ? Color(0xFF212529)
                                            : Colors.transparent),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _myListState = false;
                              });
                            },
                            child: Container(
                              height: 38.0.h,
                              width:
                                  (MediaQuery.of(context).size.width - 32.0.w) /
                                      2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '북마크 리스트',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _myListState
                                          ? Color(0xff868E96)
                                          : Color(0xFF343A40),
                                      fontSize: 16.sp,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w600,
                                      height: 1.5.h,
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 2.0.h,
                                    decoration: BoxDecoration(
                                        color: _myListState
                                            ? Colors.transparent
                                            : Color(0xFF212529)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: UsersListNavigator(
                    myListState: _myListState,
                  ),
                ),
                // height: 327.0.h,
                // width: double.infinity,
              ],
            ),
    );
  }
}
