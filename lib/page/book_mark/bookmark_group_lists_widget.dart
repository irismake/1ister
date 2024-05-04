import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lister/model/list_detail_model.dart';
import 'package:provider/provider.dart';

import '../../model/list_model.dart';
import '../../model/provider/my_groups_provider.dart';
import '../../services/api_service.dart';
import '../list_detail_page.dart';
import 'bookmark_list_page.dart';

class BookMarkGroupListsWidget extends StatefulWidget {
  final int groupId;
  const BookMarkGroupListsWidget({Key? key, required this.groupId})
      : super(key: key);

  @override
  State<BookMarkGroupListsWidget> createState() =>
      _BookMarkGroupListsWidgetState();
}

class _BookMarkGroupListsWidgetState extends State<BookMarkGroupListsWidget> {
  late Future<void> _initializeData;
  late List<ListData> myGroupLists;

  @override
  void initState() {
    super.initState();
    _initializeData = initializeData();
    print('${widget.groupId}');
  }

  Future<void> initializeData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MyGroupsProvider>(context, listen: false);
      provider.bookmarkGroupId = widget.groupId;
      print(provider.bookmarkGroupId);
      provider.initializeMyGroupListsData();
      myGroupLists = provider.myGroupLists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          return DynamicHeightGridView(
            itemCount: myGroupLists.length,
            crossAxisCount: 2,
            crossAxisSpacing: 8.0.w,
            mainAxisSpacing: 16.0.h,
            builder: (ctx, index) {
              return GestureDetector(
                onTap: () async {
                  ListDetailModel listDetailData =
                      await ApiService.getListDetail(myGroupLists[index].id);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListDetailPage(
                        title: listDetailData.title,
                        description: listDetailData.description,
                        userName: listDetailData.userName,
                        updateDate: listDetailData.updatedAt,
                        keywords: [
                          listDetailData.keyword1,
                          listDetailData.keyword2
                        ],
                      ),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 218.0.h,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF1F3F5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    SizedBox(
                      height: 12.0.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${myGroupLists[index].title}',
                        style: TextStyle(
                          color: Color.fromRGBO(52, 58, 64, 1),
                          fontSize: 14.sp,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.4.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${myGroupLists[index].username}',
                            style: TextStyle(
                              color: Color(0xFF868E96),
                              fontSize: 12.sp,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.5.h,
                            ),
                          ),
                          SizedBox(
                            width: 8.0.w,
                          ),
                          Text(
                            '${myGroupLists[index].updatedAt}',
                            style: TextStyle(
                              color: Color(0xFF868E96),
                              fontSize: 12.sp,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.5.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
