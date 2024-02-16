import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomSearchBar extends StatelessWidget {
  final ValueChanged<String>? onSearch;

  CustomSearchBar({super.key, required this.onSearch});

  //final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      padding:
          MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 12.0.w)),
      //controller: _textEditingController,
      elevation: MaterialStateProperty.all(0.0),
      constraints: BoxConstraints(
        minHeight: 48.0.h,
      ),
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(const Color(0xffF5F6F7)),
      hintText: '검색어를 입력해주세요.',

      hintStyle: MaterialStateProperty.all(
        TextStyle(
          color: Color(0xFFADB5BD),
          fontSize: 15.0.sp,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w500,
          height: 1.3.h,
        ),
      ),
      textStyle: MaterialStateProperty.all(
        TextStyle(
          color: Color(0xFF212529),
          fontSize: 15.sp,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
        ),
      ),
      onChanged: (String value) {
        print('value: $value');
      },
      //onTap: onTap,
      onSubmitted: (String value) {
        if (value.isNotEmpty) {
          onSearch?.call(value);
          print('next');
        }
        // Navigate to the next page using Navigator
      },
      leading: SvgPicture.asset(
        'assets/icons/icon_search_grey.svg',
        height: 24.0.h,
        width: 24.0.w,
      ),
    );
  }
}
