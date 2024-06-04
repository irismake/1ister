import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../components/custom_ui_kit/custom_search_bar.dart';
import '../../components/navigator/custom_app_bar.dart';
import '../../model/provider/my_groups_provider.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MyGroupsProvider>(context, listen: false);
      provider.bookmarkGroupId = widget.groupId;
      print('${provider.bookmarkGroupId}');
      provider.initializeMyGroupListsData();
    });
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
