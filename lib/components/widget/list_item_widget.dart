import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/list_detail_model.dart';

class ListItemWidget extends StatelessWidget {
  List<ItemData> items;
  ListItemWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Container(
            width: double.infinity,
            height: 106.0.h,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0xffF8F9FA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${items[index].name}',
                    style: TextStyle(
                      color: Color(0xFF343A40),
                      fontSize: 16.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      height: 1.5.h,
                    ),
                  ),
                  Text(
                    '${items[index].description}',
                    style: TextStyle(
                      color: Color(0xFF868E96),
                      fontSize: 14.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      height: 1.4.h,
                    ),
                  ),
                  Text(
                    '${items[index].keyword1}',
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
          ),
        );
      },
    );
  }
}
