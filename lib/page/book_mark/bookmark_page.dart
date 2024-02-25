import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widget/custom/custom_search_bar.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/book_mark_list_widget.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({Key? key}) : super(key: key);

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
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
              onSearch: (String value) {},
              isInHomePage: false,
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
                  return BookMarkListWidget(index: index);
                },
              ).toList(),
            )),
          ],
        ),
      ),
    );
  }
}
