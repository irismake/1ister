import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lister/model/provider/list_detail_provider.dart';
import 'package:provider/provider.dart';

import '../../model/list_detail_model.dart';
import '../custom/custom_book_mark_button.dart';
import '../custom/custom_keyword.dart';
import '../custom_app_bar.dart';
import 'list_item.dart';

class ListDetailPage extends StatefulWidget {
  final int listId;
  final bool isBookmarked;
  ListDetailPage({
    Key? key,
    required this.listId,
    required this.isBookmarked,
  }) : super(key: key);

  @override
  State<ListDetailPage> createState() => _ListDetailPageState();
}

class _ListDetailPageState extends State<ListDetailPage> {
  String title = '';
  String description = '';
  String userName = '';
  String updateDate = '';
  List<String> keywords = [];
  List<ItemData> items = [];

  @override
  void initState() {
    super.initState();
    initializeData();

    print('${widget.listId}');
  }

  Future<void> initializeData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final listDetailProvider =
          Provider.of<ListDetailProvider>(context, listen: false);
      listDetailProvider.listId = widget.listId;
      listDetailProvider.bookmarkState = widget.isBookmarked;
      listDetailProvider.initializeListDetailData().then((_) {
        setState(() {
          ListDetailModel listDetailData = listDetailProvider.listDetail;
          title = listDetailData.title;
          description = listDetailData.description;
          userName = listDetailData.userName;
          updateDate = listDetailData.updatedAt;
          keywords.add(listDetailData.keyword1);
          keywords.add(listDetailData.keyword2);
          items = listDetailData.items;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ListDetailProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: CustomAppbar(
            popState: true,
            titleText: '',
            titleState: false,
            actionButtonOnTap: () {},
            actionButton: null),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.pink,
                height: 390.h,
                width: double.infinity,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16.0.h, right: 16.0.h, top: 20.0.w, bottom: 27.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Color(0xFF343A40),
                            fontSize: 24.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                            height: 1.4.h,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                        ),
                        CustomBookMarkButton(
                          listId: widget.listId,
                          isBookMarked: provider.bookmarkState,
                          inListDetail: true,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 22.0.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        spacing: 5,
                        runSpacing: 5,
                        children: keywords.map((keyword) {
                          return KeyWord(keyWordName: keyword);
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 16.0.h,
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: Color(0xFF343A40),
                        fontSize: 15.sp,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 1.3.h,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                    ),
                    SizedBox(
                      height: 8.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                            color: Color(0xFF868E96),
                            fontSize: 14.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.428.h,
                          ),
                        ),
                        SizedBox(
                          width: 8.0.h,
                        ),
                        Text(
                          updateDate,
                          style: TextStyle(
                            color: Color(0xFF868E96),
                            fontSize: 14.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.428.h,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0.h,
                    ),
                    ListItem(
                      items: items,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
