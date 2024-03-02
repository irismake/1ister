import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../model/groups.dart';
import '../../model/provider/my_groups_provider.dart';

class CustomDropDownButton extends StatelessWidget {
  CustomDropDownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyGroupsProvider>(
      builder: (context, provider, child) {
        final List<MyGroupData> myGroups = provider.myGroups();
        final int? selectedGroupIndex = provider.selectedGroupIndex;
        return DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              '선택하세요',
              style: TextStyle(
                  color: Color(0xFFADB5BD),
                  fontSize: 15.sp,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 1),
            ),
            items: myGroups
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item.name,
                    child: Text(
                      item.name,
                      style: TextStyle(
                          color: Color(0xFFADB5BD),
                          fontSize: 15.sp,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 1),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                .toList(),
            value: selectedGroupIndex == null
                ? null
                : myGroups[selectedGroupIndex!].name,
            onChanged: (value) {
              int? index = myGroups.indexWhere((group) => group.name == value);
              provider.selectedGroupIndex = index;
            },
            buttonStyleData: ButtonStyleData(
              height: 48.0.h,
              width: 200.0.w,
              padding: EdgeInsets.only(
                  left: 12.0.w, top: 14.0.h, bottom: 14.0.h, right: 8.0.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color(0xFFDEE2E6),
                ),
                color: Colors.white,
              ),
              elevation: 0,
            ),
            iconStyleData: IconStyleData(
              icon: SizedBox(
                height: 20.0.h,
                width: 20.0.w,
                child: SvgPicture.asset(
                  'assets/icons/icon_arrow_bottom.svg',
                ),
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              elevation: 1,
              maxHeight: 150.0.h,
              width: 200.0.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              offset: const Offset(0, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all<double>(6),
                thumbVisibility: MaterialStateProperty.all<bool>(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        );
      },
    );
  }
}
