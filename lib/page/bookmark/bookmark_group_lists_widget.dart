import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lister/model/list_model.dart';
import 'package:provider/provider.dart';

import '../list/list_detail_page.dart';
import '../../model/provider/my_groups_provider.dart';

class BookMarkGroupListsWidget extends StatelessWidget {
  const BookMarkGroupListsWidget({
    Key? key,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Consumer<MyGroupsProvider>(
      builder: (context, provider, child) {
        final List<ListData> myGroupLists = provider.myGroupLists;
        return FutureBuilder(
          future: Future.delayed(const Duration(milliseconds: 500)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return DynamicHeightGridView(
                itemCount: myGroupLists.length,
                crossAxisCount: 2,
                crossAxisSpacing: 8.0.w,
                mainAxisSpacing: 16.0.h,
                builder: (ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListDetailPage(
                            listId: myGroupLists[index].id,
                            isBookmarked: myGroupLists[index].isBookmarked,
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
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.0.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${myGroupLists[index].title}',
                            style: TextStyle(
                              color: Color(0xFF343A40),
                              fontSize: 14.sp,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.4.h,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.0.h),
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
                              SizedBox(width: 8.0.w),
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
      },
    );
  }
}
