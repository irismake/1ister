import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/provider/lists_provider.dart';
import '../custom/custom_tab_bar.dart';
import '../list/user_book_mark_list.dart';
import '../list/user_my_list.dart';

class UserListNavigator extends StatefulWidget {
  const UserListNavigator({super.key});

  @override
  State<UserListNavigator> createState() => _UserListNavigatorState();
}

class _UserListNavigatorState extends State<UserListNavigator> {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetListsProvider>(
      builder: (context, provider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 16.0.w,
                right: 16.0.w,
                bottom: 20.0.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      provider.bookmarkPage = false;
                      _pageController.animateToPage(
                        0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: CustomTabBar(
                      bookmarkPage: provider.bookmarkPage,
                      tabName: '나의 리스트',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      provider.bookmarkPage = true;
                      _pageController.animateToPage(
                        1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: CustomTabBar(
                      bookmarkPage: !provider.bookmarkPage,
                      tabName: '북마크 리스트',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  provider.bookmarkPage = page == 0 ? false : true;
                },
                children: List.generate(2, (index) {
                  return index == 0 ? UserMyList() : UserBookMarkList();
                }),
              ),
            ),
          ],
        );
      },
    );
  }
}
