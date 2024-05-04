import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../model/follows_model.dart';
import '../../../widget/custom/custom_follow_button.dart';

class FollowWidget extends StatelessWidget {
  final int followCount;
  final List<FollowData> usersFollowLists;

  FollowWidget({
    required this.followCount,
    required this.usersFollowLists,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.0.h, right: 16.0.w, left: 16.0.w),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: followCount,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            height: 66.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/image_user_profile.svg',
                    width: 40.0,
                    height: 40.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${usersFollowLists[index].name}',
                            style: TextStyle(
                              color: Color(0xFF343A40),
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            '${usersFollowLists[index].bio}',
                            style: TextStyle(
                              color: Color(0xFF868E96),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                  ),
                  CustomFollowButton(),
                ],
              ),
            ),
          );
          ;
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Color(0xffDEE2E6),
            thickness: 1,
            height: 16.0,
          );
        },
      ),
    );
  }
}
