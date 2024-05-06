import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lister/model/provider/user_info_provider.dart';
import 'package:provider/provider.dart';

import '../../widget/custom/custom_search_bar.dart';
import '../../widget/custom_app_bar.dart';
import 'bookmark_groups_widget.dart';

class BookMarkPage extends StatelessWidget {
  const BookMarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInfoProvider = Provider.of<UserInfoProvider>(context);
    userInfoProvider.initializeData();
    String name =
        Provider.of<UserInfoProvider>(context, listen: false).userInfo.name;

    return Scaffold(
      appBar: CustomAppbar(
          popState: true,
          titleText: '${name}의 북마크',
          titleState: true,
          actionButtonOnTap: () {},
          actionButton: 'button_plus'),
      body: Padding(
        padding: EdgeInsets.only(
            top: 37.0.h, left: 16.0.w, right: 16.0.w, bottom: 0.0.h),
        child: Column(
          children: [
            CustomSearchBar(
              autoFocus: false,
              enabled: true,
              onSearch: (String value) {},
            ),
            SizedBox(
              height: 24.0.h,
            ),
            Expanded(
              child: BookMarkGroupsWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
