import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lister/model/custom_app_bar.dart';
import 'package:lister/model/custom_switch.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  final _cities = ['서울', '대전', '대구', '부산', '인천', '울산', '광주'];
  String? _selectedCity;
  bool _switchState = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      //_selectedCity = _cities[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          titleText: '리스트 만들기',
          titleState: true,
          actionButtonOnTap: () {},
          actionButton: null),
      body: Column(
        children: [
          Container(
            height: 176.0.h,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 24.0.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 48.0.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '그룹 선택',
                          style: TextStyle(
                            color: Color(0xFF343A40),
                            fontSize: 16.0.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          height: 48.0.h,
                          width: 200.0.w,
                          child: DecoratedBox(
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFFDEE2E6)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: DropdownButton(
                              isDense: false, // Dropdown의 높이를 조절
                              itemHeight: 60,
                              value: _selectedCity,
                              items: _cities
                                  .map((e) => DropdownMenuItem(
                                        value:
                                            e, // 선택 시 onChanged 를 통해 반환할 value
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedCity = value!;
                                });
                              },
                              icon: Padding(
                                padding: EdgeInsets.only(right: 8.0.w),
                                child: SizedBox(
                                  height: 32.0.h,
                                  width: 32.0.w,
                                  child: SvgPicture.asset(
                                    'assets/icons/icon_arrow_bottom.svg',
                                  ),
                                ),
                              ),
                              disabledHint: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.0.w, vertical: 14.0.h),
                                child: const Text(
                                  '선택하세요',
                                  style: TextStyle(
                                    color: Color(0xFFADB5BD),
                                    fontSize: 15,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                              hint: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.0.w, vertical: 14.0.h),
                                child: Text(
                                  '선택하세요',
                                  style: TextStyle(
                                      color: Color(0xFFADB5BD),
                                      fontSize: 15,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      height: 1.3.h),
                                ),
                              ),
                              elevation: 0,
                              dropdownColor: Colors.white,
                              isExpanded:
                                  true, //make true to take width of parent widget
                              underline: Container(), //empty line
                              style: TextStyle(
                                  fontSize: 15.sp, color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xFFDEE2E6),
                    thickness: 1.h,
                    height: 0,
                  ),
                  Container(
                    height: 48.0.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '순위 설정',
                          style: TextStyle(
                            color: Color(0xFF343A40),
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CustomSwitch(
                          value: _switchState,
                          enableColor: Theme.of(context).primaryColor,
                          disableColor: Color(0xFFE9ECEF),
                          width: 40.0.w,
                          height: 20.h,
                          switchHeight: 16.0.h,
                          switchWidth: 16.0.w,
                          onChanged: (bool value) {
                            setState(() {
                              _switchState = value;
                            });
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
