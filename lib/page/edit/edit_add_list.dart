import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lister/model/provider/my_groups_provider.dart';
import 'package:provider/provider.dart';

import '../../widget/custom/custom_drop_down_button.dart';
import '../../widget/custom/custom_switch.dart';
import '../../widget/custom/custom_text_field.dart';
import '../../widget/edit_enter item_widget.dart';

class EditAddList extends StatefulWidget {
  EditAddList({super.key});

  @override
  State<EditAddList> createState() => _EditAddListState();
}

class _EditAddListState extends State<EditAddList> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _cities = ['서울', '대전', '대구', '부산', '인천', '울산', '광주'];

  bool _switchState = false;

  bool _itemState = false;

  int _itemNum = 0;

  XFile? _image; //이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

  //이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
  }

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 24.0.h),
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
                      ChangeNotifierProvider<MyGroupsProvider>(
                        create: (context) => MyGroupsProvider(),
                        child: CustomDropDownButton(),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Color(0xFFDEE2E6),
                  thickness: 1.h,
                  height: 32.0.h,
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
                      CustomRankingSwitch(
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
          Container(
            height: 12.0.h,
            color: Color(0xFFf5f5f5),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 24.0.h),
            child: Column(
              children: [
                SizedBox(
                  height: 140.0.h,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 80.0.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '이미지 등록',
                            style: TextStyle(
                              color: Color(0xFF212529),
                              fontSize: 16.sp,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.5.h,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                getImage(ImageSource.gallery);
                              });
                            },
                            child: _image != null
                                ? Container(
                                    width: 80.0.w,
                                    height: 100.0.h,
                                    child: Image.file(File(
                                        _image!.path)), //가져온 이미지를 화면에 띄워주는 코드
                                  )
                                : SizedBox(
                                    width: 80.0.w,
                                    height: 100.0.h,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: SvgPicture.asset(
                                        'assets/icons/icon_plus_image.svg',
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0.h,
                ),
                SizedBox(
                  height: 16.0.h,
                ),
                CustomTextField(
                  prefixState: false,
                  labelState: true,
                  labelText: '내용 입력',
                  height: 120.0.h,
                  fieldHeight: 80.0.h,
                  textStyle: TextStyle(
                      decorationThickness: 0,
                      fontFamily: 'PretendardRegular',
                      fontSize: 16.sp,
                      color: Color(0xff343A40),
                      fontWeight: FontWeight.w700,
                      height: 1.5.h),
                  controller: titleController,
                ),
                SizedBox(
                  height: 12.0.h,
                ),
                CustomTextField(
                  prefixState: false,
                  labelState: false,
                  labelText: '',
                  height: 95.0.h,
                  fieldHeight: 95.0.h,
                  textStyle: TextStyle(
                      decorationThickness: 0,
                      fontFamily: 'PretendardRegular',
                      fontSize: 14.sp,
                      color: Color(0xff343A40),
                      fontWeight: FontWeight.w500,
                      height: 1.5.h),
                  controller: descriptionController,
                ),
                Divider(
                  color: Color(0xFFDEE2E6),
                  thickness: 1.h,
                  height: 40.0.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '항목 입력',
                    style: TextStyle(
                      color: Color(0xFF212529),
                      fontSize: 16.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 1.5.h,
                    ),
                  ),
                ),
                _itemState
                    ? Column(
                        children: [
                          SizedBox(height: 20.0.h),
                          EditEnterItem(
                            itemNum: _itemNum,
                          ),
                        ],
                      )
                    : SizedBox(height: 20.0.h),
                InkWell(
                  onTap: () {
                    setState(() {
                      _itemState = true;
                      _itemNum++;
                    });
                  },
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Color(0xFFF8F9FA),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    height: 64.0.h,
                    width: double.infinity,
                    child: Center(
                      child: SizedBox(
                        height: 32.0.h,
                        child: SvgPicture.asset(
                          'assets/icons/icon_circle_plus.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 12.0.h,
            color: Color(0xFFf5f5f5),
          ),
          Container(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 24.0.h),
              child: Column(
                children: [
                  Container(
                    height: 104.0.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '키워드 추가',
                              style: TextStyle(
                                color: Color(0xFF343A40),
                                fontSize: 16.sp,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                height: 1.5.h,
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
                                  // value: _myGroup,
                                  items: _cities
                                      .map((e) => DropdownMenuItem(
                                            value:
                                                e, // 선택 시 onChanged 를 통해 반환할 value
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    // _myGroup = value!;
                                  },
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 8.0.w),
                                    child: SizedBox(
                                      height: 20.0.h,
                                      width: 20.0.w,
                                      child: SvgPicture.asset(
                                        'assets/icons/icon_arrow_bottom.svg',
                                      ),
                                    ),
                                  ),
                                  disabledHint: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.0.w, vertical: 14.0.h),
                                    child: Text(
                                      '선택하세요',
                                      style: TextStyle(
                                        color: Color(0xFFADB5BD),
                                        fontSize: 15.sp,
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
                                          fontSize: 15.sp,
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
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 200.0.w,
                            height: 48.0.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0.w, vertical: 12.0.h),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF5F6F7),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '직접입력',
                                  style: TextStyle(
                                    color: Color(0xFFADB5BD),
                                    fontSize: 15.sp,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xFFDEE2E6),
                    thickness: 1.h,
                    height: 32.0.h,
                  ),
                  Container(
                    height: 48.0.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '공개여부',
                          style: TextStyle(
                            color: Color(0xFF343A40),
                            fontSize: 16.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 1.5.h,
                          ),
                        ),
                        CustomPrivateSwitch(
                          value: _switchState,
                          enableColor: Theme.of(context).primaryColor,
                          disableColor: Color(0xFFADB5BD),
                          width: 122.0.w,
                          height: 32.h,
                          switchHeight: 32.0.h,
                          switchWidth: 60.0.w,
                          onChanged: (bool value) {
                            setState(() {
                              _switchState = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 18.0.h,
            color: Color(0xFFf5f5f5),
          ),
        ],
      ),
    );
  }
}
