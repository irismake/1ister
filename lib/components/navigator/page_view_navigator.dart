import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../page/user/follow/follow_widget.dart';
import '../custom_ui_kit/custom_tab_bar.dart';
import '../../page/user/users_list/user_book_mark_list.dart';
import '../../page/user/users_list/user_my_list.dart';

class PageViewNavigator extends StatefulWidget {
  final bool followState;
  final dynamic provider;
  final String tabName_0;
  final String tabName_1;
  final int initialPage;

  const PageViewNavigator({
    super.key,
    required this.followState,
    required this.provider,
    required this.tabName_0,
    required this.tabName_1,
    required this.initialPage,
  });

  @override
  State<PageViewNavigator> createState() => _PageViewNavigatorState();
}

class _PageViewNavigatorState extends State<PageViewNavigator> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    initializeData();
    _pageController =
        PageController(initialPage: widget.initialPage, viewportFraction: 1);
  }

  Future<void> initializeData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.provider.initializeData();
      widget.provider.pageState = widget.initialPage == 0 ? false : true;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 16.0.w,
            right: 16.0.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  widget.provider.pageState = false;
                  _pageController.animateToPage(
                    0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: CustomTabBar(
                  pageState: widget.provider.pageState,
                  tabName: widget.tabName_0,
                ),
              ),
              InkWell(
                onTap: () {
                  widget.provider.pageState = true;
                  _pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: CustomTabBar(
                  pageState: !widget.provider.pageState,
                  tabName: widget.tabName_1,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (page) {
              widget.provider.pageState = page == 0 ? false : true;
            },
            children: List.generate(
              2,
              (index) {
                return widget.followState
                    ? index == 0
                        ? FollowWidget(
                            followCount: widget.provider.usersFollowerCount,
                            usersFollowLists:
                                widget.provider.usersFollowerLists,
                          )
                        : FollowWidget(
                            followCount: widget.provider.usersFollowingCount,
                            usersFollowLists:
                                widget.provider.usersFollowingLists,
                          )
                    : index == 0
                        ? UserMyList()
                        : UserBookMarkList();
              },
            ),
          ),
        ),
      ],
    );
  }
}
