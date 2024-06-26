import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../model/list_model.dart';
import '../../../model/provider/get_lists_provider.dart';
import '../../edit/edit_page.dart';
import '../../list/list_detail_page.dart';
import '../../../components/custom_ui_kit/custom_book_mark_button.dart';

class UserMyList extends StatelessWidget {
  const UserMyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GetListsProvider>(
      builder: (context, provider, child) {
        final List<ListData> usersMyLists = provider.usersMyLists;
        return usersMyLists.isEmpty
            ? Container(
                color: Color(0xffF8F9FA),
                child: Center(
                  child: SizedBox(
                    height: 100.0.h,
                    // width: 165.0.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "아직 리스트가 비어있어요.",
                          style: TextStyle(
                            color: Color(0xFF495057),
                            fontSize: 15.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 1.5.h,
                          ),
                        ),
                        SizedBox(
                          height: 52.0.h,
                          width: 165.0.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Color(0xFFE9ECEF),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditPage()),
                              );
                            },
                            child: Text(
                              '리스트 만들기',
                              style: TextStyle(
                                color: Color(0xff212529),
                                fontSize: 15.sp,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w700,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0.w,
                  vertical: 20.0.h,
                ),
                child: DynamicHeightGridView(
                  itemCount: usersMyLists.length,
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0.w,
                  mainAxisSpacing: 16.0.h,
                  builder: (ctx, index) {
                    return GestureDetector(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListDetailPage(
                              listId: usersMyLists[index].id,
                              isBookmarked: usersMyLists[index].isBookmarked,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 218.0.h,
                                width: double.infinity,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF1F3F5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                              SizedBox(
                                height: 12.0.h,
                              ),
                              Text(
                                '${usersMyLists[index].title}',
                                style: TextStyle(
                                  color: Color(0xFF343A40),
                                  fontSize: 14.sp,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  height: 1.42.h,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              SizedBox(
                                height: 4.0.h,
                              ),
                              Text(
                                '${usersMyLists[index].updatedAt}',
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
                              listId: usersMyLists[index].id,
                              isBookMarked: usersMyLists[index].isBookmarked,
                              inListDetail: false,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}
