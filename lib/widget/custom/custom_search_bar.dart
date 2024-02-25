import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lister/page/search/search_page.dart';

class CustomSearchBar extends StatelessWidget {
  final ValueChanged<String>? onSearch;
  final bool autoFocus;
  final bool enabled;

  CustomSearchBar(
      {Key? key,
      required this.onSearch,
      required this.autoFocus,
      required this.enabled});

  @override
  Widget build(BuildContext context) {
    //FocusNode focusNode = FocusNode();
    return TextFormField(
      enabled: enabled,
      autofocus: autoFocus,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Color(0xffF5F6F7),
        hintText: '검색어를 입력해주세요.',
        hintStyle: TextStyle(
          color: Color(0xFFADB5BD),
          fontSize: 15.0.sp,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w500,
          height: 1.3.h,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(
              top: 12.0.h, bottom: 12.0.h, left: 12.0.w, right: 6.w),
          child: SvgPicture.asset(
            'assets/icons/icon_search_grey.svg',
          ),
        ),
      ),
      style: TextStyle(
        color: Color(0xFF212529),
        fontSize: 15.sp,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w600,
      ),
      //focusNode: focusNode,
      onChanged: (String value) {
        print('value: $value');
      },
      onFieldSubmitted: (String value) {
        if (value.isNotEmpty) {
          onSearch?.call(value);
          print('next');
        }
        // Navigate to the next page using Navigator
      },
    );
  }
}
