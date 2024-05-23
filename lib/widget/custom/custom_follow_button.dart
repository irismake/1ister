import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/provider/follows_provider.dart';

class CustomFollowButton extends StatelessWidget {
  final bool isFollow;
  final int followUserId;
  const CustomFollowButton(
      {super.key, required this.isFollow, required this.followUserId});

  @override
  Widget build(BuildContext context) {
    return Consumer<FollowsProvider>(builder: (context, provider, child) {
      return InkWell(
        onTap: () async {
          await provider.onTapFollowButton(context, followUserId, isFollow);
        },
        child: Container(
          decoration: ShapeDecoration(
            color: isFollow ? Color(0xFF495057) : Color(0xFFF1F3F5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 6.0.h),
            child: Text(
              isFollow ? '팔로잉' : '팔로우',
              style: TextStyle(
                color: isFollow ? Colors.white : Color(0xFF495057),
                fontSize: 14.sp,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
        ),
      );
    });
  }
}
