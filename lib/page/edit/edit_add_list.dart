import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lister/model/provider/my_groups_provider.dart';
import 'package:provider/provider.dart';

import '../../model/my_group_model.dart';
import '../../model/keyword_model.dart';
import '../../model/provider/create_list_provider.dart';
import '../../model/provider/keywords_provider.dart';
import '../../widget/custom/custom_drop_down_button.dart';
import '../../widget/custom/custom_keyword.dart';
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
  TextEditingController bioController = TextEditingController();
  TextEditingController keywordController = TextEditingController();

  late FocusNode titleFocusNode;
  late FocusNode bioFocusNode;
  //FocusNode keywordFocusNode = FocusNode();

  bool _rankingState = false;
  bool _privateState = false;
  bool _itemState = false;
  int _itemNum = 0;

  XFile? _image;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    titleFocusNode = FocusNode();
    bioFocusNode = FocusNode();

    titleFocusNode.addListener(_onTitleFocusChanged);
    bioFocusNode.addListener(_onDescriptionFocusChanged);

    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    bioController.dispose();
    keywordController.dispose();
    titleFocusNode.dispose();
    bioFocusNode.dispose();
    super.dispose();
  }

  void _onTitleFocusChanged() {
    if (!titleFocusNode.hasFocus) {
      Provider.of<CreateListProvider>(context, listen: false).submittedTitle =
          titleController.text;
    }
  }

  void _onDescriptionFocusChanged() {
    if (!bioFocusNode.hasFocus) {
      Provider.of<CreateListProvider>(context, listen: false)
          .submittedDescription = bioController.text;
    }
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
                      Consumer<MyGroupsProvider>(
                        builder: (context, provider, child) {
                          final List<MyGroupData> myGroups =
                              provider.myGroups();
                          return CustomDropDownButton(
                              dropDownItems: myGroups, provider: provider);
                        },
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
                        value: _rankingState,
                        enableColor: Theme.of(context).primaryColor,
                        disableColor: Color(0xFFE9ECEF),
                        width: 40.0.w,
                        height: 20.h,
                        switchHeight: 16.0.h,
                        switchWidth: 16.0.w,
                        onChanged: (bool value) {
                          setState(() {
                            _rankingState = value;
                          });
                          Provider.of<CreateListProvider>(context,
                                  listen: false)
                              .submittedIsRankingList = value;
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
                  focusNode: titleFocusNode,
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
                  controller: bioController,
                  focusNode: bioFocusNode,
                ),
                Divider(
                  color: Color(0xFFDEE2E6),
                  thickness: 1.h,
                  height: 40.0.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _rankingState
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '순위 설정',
                              style: TextStyle(
                                color: Color(0xFF212529),
                                fontSize: 16.sp,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                height: 1.5.h,
                              ),
                            ),
                            SizedBox(
                              height: 8.0.h,
                            ),
                            Text(
                              '내용을 드래그하여 순위를 설정해보세요.',
                              style: TextStyle(
                                color: Color(0xFF868E96),
                                fontSize: 14.sp,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                height: 1.4.h,
                              ),
                            ),
                          ],
                        )
                      : Text(
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

                      print("item number : $_itemNum");
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
                  Consumer<KeywordsProvider>(
                    builder: (context, provider, child) {
                      final List<KeywordData> keywords = provider.keywords;
                      final bool keywordState = provider.keywordState;
                      return Column(
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
                              CustomDropDownButton(
                                  dropDownItems: keywords, provider: provider),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0.h),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 200.0.w,
                                height: 48.0.h,
                                child: TextFormField(
                                  controller: keywordController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 14.0.w),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Color(0xffF5F6F7),
                                    hintText: '직접입력',
                                    hintStyle: TextStyle(
                                      color: Color(0xffADB5BD),
                                      fontSize: 15.0.sp,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      height: 1,
                                    ),
                                  ),
                                  style: TextStyle(
                                    decorationThickness: 0,
                                    color: Color(0xFF212529),
                                    fontSize: 15.sp,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  onFieldSubmitted: (String value) {
                                    KeywordData keywordData = KeywordData(
                                      name: value,
                                    );
                                    KeywordsProvider provider =
                                        Provider.of<KeywordsProvider>(context,
                                            listen: false);
                                    provider.addKeyword(keywordData);
                                    keywordController.clear();
                                  },
                                ),
                              ),
                            ),
                          ),
                          keywordState
                              ? SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.end,
                                    spacing: 5,
                                    runSpacing: 5,
                                    children: keywords.map((keywords) {
                                      return KeyWord(
                                          keyWordName: keywords.name);
                                    }).toList(),
                                  ),
                                )
                              : SizedBox()
                        ],
                      );
                    },
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
                          value: _privateState,
                          enableColor: Theme.of(context).primaryColor,
                          disableColor: Color(0xFFADB5BD),
                          width: 122.0.w,
                          height: 32.h,
                          switchHeight: 32.0.h,
                          switchWidth: 60.0.w,
                          onChanged: (bool value) {
                            setState(() {
                              _privateState = value;
                            });

                            Provider.of<CreateListProvider>(context,
                                    listen: false)
                                .submittedIsPrivate = value;
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
