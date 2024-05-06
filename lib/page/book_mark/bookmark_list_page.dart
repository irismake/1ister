import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/provider/my_groups_provider.dart';
import '../../widget/custom/custom_search_bar.dart';
import '../../widget/custom_app_bar.dart';
import 'bookmark_group_lists_widget.dart';
import 'bookmark_groups_widget.dart';

class BookmarkListPage extends StatelessWidget {
  final String groupTitle;
  final int groupId;
  const BookmarkListPage({
    super.key,
    required this.groupTitle,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          popState: true,
          titleText: '${groupTitle}',
          titleState: true,
          actionButtonOnTap: () {},
          actionButton: 'button_more'),
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
            Consumer<MyGroupsProvider>(builder: (context, provider, child) {
              //provider.bookmarkGroupId = groupId;
              // WidgetsBinding.instance.addPostFrameCallback((_) {
              //   provider.initializeMyGroupListsData();
              // });

              //print(provider.bookmarkGroupId);
              return Expanded(
                child: BookMarkGroupListsWidget(
                  groupId: groupId,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
