import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTabButton extends StatelessWidget {
  late final String iconName;

  CustomTabButton({
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
