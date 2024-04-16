import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/provider/get_follow_provider.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/navigator/page_view_navigator.dart';

class UserFollowsPage extends StatelessWidget {
  final String name;
  final int initialPage;

  const UserFollowsPage({
    super.key,
    required this.name,
    required this.initialPage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          popState: true,
          titleText: name,
          titleState: true,
          actionButtonOnTap: () {},
          actionButton: 'button_hamburger'),
      body: Padding(
        padding: EdgeInsets.only(top: 24.0.h),
        child: Consumer<GetFollowsProvider>(
          builder: (context, getFollowsProvider, child) {
            final provider = getFollowsProvider;
            return PageViewNavigator(
              followState: true,
              provider: provider,
              tabName_0: '팔로워',
              tabName_1: '팔로잉',
              initialPage: initialPage,
            );
          },
        ),
      ),
    );
  }
}
