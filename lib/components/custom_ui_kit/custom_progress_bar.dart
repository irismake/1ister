import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressBar extends StatelessWidget implements PreferredSizeWidget {
  final int progress;
  final int totalProgress;

  ProgressBar({required this.progress, required this.totalProgress});

  @override
  Size get preferredSize => Size.fromHeight(4.0.h);

  @override
  Widget build(BuildContext context) {
    final appWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: appWidth * progress / totalProgress,
              height: 4.h,
              color: Color(0xff212529),
            ),
            Expanded(
              child: Container(
                width: appWidth * 2 / 3,
                height: 4.h,
                color: Color(0xffE9ECEF),
              ),
            ),
          ],
        )
      ],
    );
  }
}
