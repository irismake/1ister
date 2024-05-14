import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:provider/provider.dart";

import '../../model/list_model.dart';
import '../../model/provider/get_lists_provider.dart';
import '../../page/list_detail_page.dart';
import '../custom/custom_book_mark_button.dart';

class HomeListView extends StatelessWidget {
  HomeListView({Key? key});
  @override
  Widget build(BuildContext context) {
    return Consumer<GetListsProvider>(builder: (context, provider, child) {
      provider.initializeMainLists();
      final List<ListData> mainLists = provider.mainLists;
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mainLists.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListDetailPage(
                    listId: mainLists[index].id,
                    isBookmarked: mainLists[index].isBookmarked,
                  ),
                ),
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
                          '${mainLists[index].updatedAt}',
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
                    Positioned(
                      top: 4.0.h,
                      right: 0.0,
                      child: CustomBookMarkButton(
                        listId: mainLists[index].id,
                        isBookMarked: mainLists[index].isBookmarked,
                        inListDetail: false,
                      ),
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
