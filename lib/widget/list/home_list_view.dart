import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:provider/provider.dart";
import 'package:intl/intl.dart';

import '../../model/list_model.dart';
import '../../model/provider/get_lists_provider.dart';
import '../../page/list_detail_page.dart';
import '../../services/api_service.dart';
import '../custom/custom_book_mark_button.dart';

class HomeListView extends StatelessWidget {
  HomeListView({Key? key});
  @override
  Widget build(BuildContext context) {
    return Consumer<GetListsProvider>(builder: (context, provider, child) {
      final List<ListData> mainLists = provider.mainLists();
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mainLists.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              Map<String, dynamic> listData =
                  await ApiService.getListDetail(mainLists[index].id);
              final title = utf8.decode(listData['title'].toString().codeUnits);
              final description =
                  utf8.decode(listData['description'].toString().codeUnits);
              final userName =
                  utf8.decode(listData['user_name'].toString().codeUnits);
              final updateDate = DateFormat('yy.MM.dd')
                  .format(DateTime.parse(listData['updated_at']));
              List<String> keywords = [];
              keywords
                  .add(utf8.decode(listData['keyword_1'].toString().codeUnits));
              keywords
                  .add(utf8.decode(listData['keyword_2'].toString().codeUnits));
              print(keywords);

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListDetailPage(
                          title: title,
                          description: description,
                          userName: userName,
                          updateDate: updateDate,
                          keywords: keywords,
                        )),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 12.0.w),
              child: SizedBox(
                width: 160.0,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200.0,
                          width: double.infinity,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF1F3F5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        Text(
                          '${mainLists[index].title}',
                          style: TextStyle(
                            color: Color(0xFF343A40),
                            fontSize: 16.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 1.5.h,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          '${DateFormat('yy.MM.dd').format(DateTime.parse(mainLists[index].updatedAt))}',
                          style: TextStyle(
                            color: Color(0xFF868E96),
                            fontSize: 12.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.5.h,
                          ),
                        )
                      ],
                    ),
                    CustomBookMarkButton(
                      index: index,
                      listId: mainLists[index].id,
                      isBookMarked: mainLists[index].isBookmarked,
                      tag: 'mainList',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
