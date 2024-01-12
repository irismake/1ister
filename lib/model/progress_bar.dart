import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressBar extends StatelessWidget implements PreferredSizeWidget {

  final progress;
  final totalProgress;

  ProgressBar({required this.progress, required this.totalProgress});

  @override
  Size get preferredSize => Size.fromHeight(58.0.h); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    final appWidth = MediaQuery.of(context).size.width;
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 54.h,
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: appWidth * progress/totalProgress,
                  height: 4.h,
                  color: Color(0xff212529),
                ),
                Expanded(
                  child :Container(
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
