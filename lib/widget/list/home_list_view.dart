import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:provider/provider.dart";
import 'package:intl/intl.dart';

import '../../model/provider/list_provider.dart';
import '../custom/custom_book_mark_button.dart';

class HomeListView extends StatelessWidget {
  HomeListView({Key? key});

  @override
  Widget build(BuildContext context) {
    final mainLists = Provider.of<MainListsProvider>(context).mainLists();
    print(mainLists);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: mainLists.length,
      itemBuilder: (context, index) {
        return Padding(
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
                      '${utf8.decode(mainLists[index].title.runes.toList())}',
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
                  isBookMarked: mainLists[index].isBookmarked,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
