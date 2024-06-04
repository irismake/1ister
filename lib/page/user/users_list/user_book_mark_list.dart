import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../../model/list_model.dart';
import '../../../model/provider/get_lists_provider.dart';
import '../../list/list_detail_page.dart';
import '../../../components/custom_ui_kit/custom_book_mark_button.dart';

class UserBookMarkList extends StatelessWidget {
  const UserBookMarkList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GetListsProvider>(
      builder: (context, provider, child) {
        final List<ListData> usersBookmarkLists = provider.usersBookmarkLists;

        return usersBookmarkLists.isEmpty
            ? Container(
                color: Color(0xffF8F9FA),
                child: Center(
                  child: Text(
                    "아직 북마크 리스트가 비어있어요.",
                    style: TextStyle(
                      color: Color(0xff495057),
                      fontSize: 16.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 1.5.h,
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
                  itemCount: usersBookmarkLists.length,
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
                              listId: usersBookmarkLists[index].id,
                              isBookmarked:
                                  usersBookmarkLists[index].isBookmarked,
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
                                '${usersBookmarkLists[index].title}',
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${usersBookmarkLists[index].username}',
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
                                    '${usersBookmarkLists[index].updatedAt}',
                                    style: TextStyle(
                                      color: Color(0XFF868E96),
                                      fontSize: 12.sp,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      height: 1.5.h,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Positioned(
                            top: 4.0.h,
                            right: 0.0,
                            child: CustomBookMarkButton(
                              listId: usersBookmarkLists[index].id,
                              isBookMarked:
                                  usersBookmarkLists[index].isBookmarked,
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
