import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/provider/my_groups_provider.dart';
import '../../widget/custom/custom_search_bar.dart';
import '../../widget/custom_app_bar.dart';
import 'bookmark_group_lists_widget.dart';

class BookmarkListPage extends StatefulWidget {
  final String groupTitle;
  final int groupId;

  const BookmarkListPage({
    super.key,
    required this.groupTitle,
    required this.groupId,
  });

  @override
  State<BookmarkListPage> createState() => _BookmarkListPageState();
}

class _BookmarkListPageState extends State<BookmarkListPage> {
  @override
  void initState() {
    super.initState();
    fetchGroupId();
  }

  Future<void> fetchGroupId() async {
    final provider = Provider.of<MyGroupsProvider>(context, listen: false);
    provider.bookmarkGroupId = widget.groupId;
    print('${provider.bookmarkGroupId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          popState: true,
          titleText: '${widget.groupTitle}',
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
            Expanded(
              child: BookMarkGroupListsWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
