import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../components/navigator/custom_app_bar.dart';
import '../../../components/navigator/page_view_navigator.dart';
import '../../../model/provider/follows_provider.dart';

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
        child: Consumer<FollowsProvider>(
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
