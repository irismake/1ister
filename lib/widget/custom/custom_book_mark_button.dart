import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../model/provider/get_lists_provider.dart';

class CustomBookMarkButton extends StatelessWidget {
  final int listId;
  final bool isBookMarked;

  const CustomBookMarkButton({
    required this.listId,
    required this.isBookMarked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 4.0.h,
      right: 0.0,
      child: SizedBox(
        height: 32.0.h,
        width: 32.0.w,
        child: InkWell(
          onTap: () async {
            print('g');
            await Provider.of<GetListsProvider>(context, listen: false)
                .onTapBookMark(listId, isBookMarked);
          },
          child: isBookMarked
              ? SvgPicture.asset('assets/icons/button_book_mark_fill_white.svg')
              : SvgPicture.asset(
                  'assets/icons/button_book_mark_empty_white.svg'),
        ),
      ),
    );
  }
}
