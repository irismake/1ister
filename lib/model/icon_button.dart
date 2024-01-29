import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lister/page/book_mark/bookmark_page.dart';
import 'package:lister/page/edit/guide_page.dart';
import 'package:lister/model/home_page_navigator.dart';
import 'package:lister/page/search/search_page.dart';
import 'package:lister/page/user/user_page.dart';

class CustomIconButton extends StatelessWidget {
  late final String iconName;

  CustomIconButton({
    required this.iconName,
  });

  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/${iconName}.svg',
      height: 32.0.h,
      width: 32.0.w,
    );
  }
}
