import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widget/custom_app_bar.dart';
import '../../widget/search_list_widget.dart';

class UserFollowsPage extends StatefulWidget {
  final String name;
  final bool followState;
  final List<dynamic> followsInfo;
  const UserFollowsPage(
      {super.key,
      required this.name,
      required this.followState,
      required this.followsInfo});

  @override
  State<UserFollowsPage> createState() => _UserFollowsPageState();
}

class _UserFollowsPageState extends State<UserFollowsPage> {
  late bool _followerState;
  late bool _followingState;

  @override
  void initState() {
    super.initState();
    print(widget.followsInfo);
    if (widget.followState) {
      _followerState = true;
      _followingState = false;
    } else {
      _followerState = false;
      _followingState = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          popState: true,
          titleText: widget.name,
          titleState: true,
          actionButtonOnTap: () {},
          actionButton: 'button_hamburger'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.0.h),
        child: Column(
          children: [
            SizedBox(
              height: 38,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _followerState = true;
                        _followingState = false;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '팔로워',
                          style: TextStyle(
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                        Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: _followerState,
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 400),
                            opacity: _followerState ? 1 : 0,
                            child: Container(
                              height: 2.0.h,
                              decoration: BoxDecoration(
                                color: Color(0xff212529),
                              ),
                              width:
                                  (MediaQuery.of(context).size.width - 32.0.w) /
                                      2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _followerState = false;
                        _followingState = true;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '팔로잉',
                          style: TextStyle(
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.5),
                        ),
                        Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: _followingState,
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 400),
                            opacity: _followingState ? 1 : 0,
                            child: Container(
                              height: 2.0.h,
                              decoration: BoxDecoration(
                                color: Color(0xff212529),
                              ),
                              width:
                                  (MediaQuery.of(context).size.width - 32.0.w) /
                                      2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: Future.delayed(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0.h),
                      child: ListViewWidget(
                        searchText: '',
                        listState: false,
                        itemState: false,
                        userState: true,
                        userInfo: widget.followsInfo,
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
