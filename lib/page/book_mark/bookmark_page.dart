import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lister/model/custom_list_bookMark.dart';
import 'package:lister/model/custom_search_bar.dart';
import 'package:lister/page/search/search_page.dart';
import 'package:lister/model/custom_app_bar.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final _pages = [
    '1',
    '1',
    '1',
    '1',
    '1',
    '1',
    '1',
    '1',
    '1',
    '1',
    '1',
    '1',
    '1',
    '1',
  ];
  final _navigatorKeyList = List.generate(5, (index) => ());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
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
              onSearch: (String value) {},
            ),
            SizedBox(
              height: 24.0.h,
            ),
            Expanded(
                child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0.w, //좌우 간격
              mainAxisSpacing: 16.0.h, //상하 간격
              childAspectRatio: (175.0.w / 266.0.h),
              children: _pages.map(
                (page) {
                  int index = _pages.indexOf(page);
                  return CustomBookMarkList(index: index);
                },
              ).toList(),
            )),
          ],
        ),
      ),
    );
  }
}
