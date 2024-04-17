import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/myGroupModel.dart';
import '../../model/provider/my_groups_provider.dart';
import '../../widget/custom/custom_search_bar.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/book_mark_list_widget.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({Key? key}) : super(key: key);

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          popState: true,
          titleText: '지니의 북마크',
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
              child: BookMarkListWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
