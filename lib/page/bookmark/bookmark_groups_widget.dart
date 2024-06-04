import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/my_group_model.dart';
import '../../model/provider/my_groups_provider.dart';
import 'bookmark_list_page.dart';

class BookMarkGroupsWidget extends StatelessWidget {
  const BookMarkGroupsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyGroupsProvider>(
      builder: (context, provider, child) {
        final List<MyGroupData> myGroups = provider.myGroups;
        final List<MyGroupData> isBucketGroup = provider.isBucketGroup;

        return FutureBuilder(
          future: provider.initializeMyGroupData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return isBucketGroup.isNotEmpty
                  ? DynamicHeightGridView(
                      itemCount: myGroups.length + 1,
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0.w,
                      mainAxisSpacing: 16.0.h,
                      builder: (ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookmarkListPage(
                                  groupTitle: index == 0
                                      ? '모든 리스트 (${isBucketGroup[0].listCount})'
                                      : '${myGroups[index - 1].name} (${myGroups[index - 1].listCount})',
                                  groupId: index == 0
                                      ? isBucketGroup[0].id
                                      : myGroups[index - 1].id,
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
                                  index == 0
                                      ? '모든 리스트 (${isBucketGroup[0].listCount})'
                                      : '${myGroups[index - 1].name} (${myGroups[index - 1].listCount})',
                                  style: TextStyle(
                                    color: Color(0xFF343A40),
                                    fontSize: 14.sp,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    height: 1.4.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}
