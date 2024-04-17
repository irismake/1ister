import 'dart:convert';

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../model/myGroupModel.dart';
import '../model/provider/my_groups_provider.dart';

class BookMarkListWidget extends StatelessWidget {
  const BookMarkListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyGroupsProvider>(
      builder: (context, provider, child) {
        final List<MyGroupData> myGroups = provider.myGroups();
        print(" hggg$myGroups");
        return FutureBuilder(
          future: provider.initializeData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return DynamicHeightGridView(
                itemCount: myGroups.length,
                crossAxisCount: 2,
                crossAxisSpacing: 8.0.w,
                mainAxisSpacing: 16.0.h,
                builder: (ctx, index) {
                  return GestureDetector(
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
                            '${myGroups[index].name} (${myGroups[index].listCount})',
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
              );
            }
          },
        );
      },
    );
  }
}
