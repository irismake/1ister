import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:lister/services/api_service.dart';
import 'package:provider/provider.dart';
import '../../model/provider/user_info_provider.dart';
import '../../widget/custom/custom_next_page_button.dart';
import '../../widget/custom/custom_text_field.dart';
import '../../widget/custom_app_bar.dart';

class UserEditInfoPage extends StatefulWidget {
  final String userName;
  final String name;
  final String? bio;
  final String picture;

  const UserEditInfoPage({
    super.key,
    required this.userName,
    required this.name,
    required this.bio,
    required this.picture,
  });

  @override
  State<UserEditInfoPage> createState() => _UserEditInfoPageState();
}

class _UserEditInfoPageState extends State<UserEditInfoPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  late FocusNode userNameFocusNode;
  late FocusNode nameFocusNode;
  late FocusNode bioFocusNode;

  late String changedUserName;
  late String changedName;
  late String changedBio;

  void initState() {
    super.initState();
    changedUserName = widget.userName;
    changedName = widget.name;
    changedBio = widget.bio ?? '';
    userNameController.text = widget.userName;
    nameController.text = widget.name;
    bioController.text = widget.bio ?? '';
    userNameFocusNode = FocusNode();
    nameFocusNode = FocusNode();
    bioFocusNode = FocusNode();
    userNameFocusNode.addListener(_onUserNameFocusChanged);
    nameFocusNode.addListener(_onNameFocusChanged);
    bioFocusNode.addListener(_onBioFocusChanged);
  }

  void _onUserNameFocusChanged() {
    if (!userNameFocusNode.hasFocus) {
      changedUserName = userNameController.text;
    }
  }

  void _onNameFocusChanged() {
    if (!nameFocusNode.hasFocus) {
      changedName = nameController.text;
    }
  }

  void _onBioFocusChanged() {
    if (!bioFocusNode.hasFocus) {
      changedBio = bioController.text;
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    nameController.dispose();
    bioController.dispose();
    userNameFocusNode.dispose();
    nameFocusNode.dispose();
    bioFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppbar(
          popState: false,
          titleText: '계정 편집',
          titleState: true,
          actionButtonOnTap: () {},
          actionButton: null,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0.h, horizontal: 16.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 471.0.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 96.0.h,
                      width: 64.0.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/images/image_user_profile.svg',
                            height: 64.0.h,
                            width: 64.0.w,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Center(
                              child: Text(
                                '사진 수정',
                                style: TextStyle(
                                    fontFamily: 'PretendardRegular',
                                    fontSize: 15.sp,
                                    color: Color(0xff495057),
                                    fontWeight: FontWeight.w500,
                                    height: 1.3.h),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomTextField(
                      prefixState: true,
                      labelState: true,
                      labelText: '사용자 아이디',
                      height: 88.0.h,
                      fieldHeight: 56.0.h,
                      textStyle: TextStyle(
                          decorationThickness: 0,
                          fontFamily: 'PretendardRegular',
                          fontSize: 16.sp,
                          color: Color(0xff868E96),
                          fontWeight: FontWeight.w700,
                          height: 1.5.h),
                      controller: userNameController,
                      focusNode: userNameFocusNode,
                    ),
                    CustomTextField(
                      prefixState: false,
                      labelState: true,
                      labelText: '이름',
                      height: 88.0.h,
                      fieldHeight: 56.0.h,
                      textStyle: TextStyle(
                          decorationThickness: 0,
                          fontFamily: 'PretendardRegular',
                          fontSize: 16.sp,
                          color: Color(0xff343A40),
                          fontWeight: FontWeight.w700,
                          height: 1.5.h),
                      controller: nameController,
                      focusNode: nameFocusNode,
                    ),
                    CustomTextField(
                      prefixState: false,
                      labelState: true,
                      labelText: '사용자 소개',
                      height: 127.0.h,
                      fieldHeight: 95.0.h,
                      textStyle: TextStyle(
                          decorationThickness: 0,
                          fontFamily: 'PretendardRegular',
                          fontSize: 14.sp,
                          color: Color(0xff343A40),
                          fontWeight: FontWeight.w500,
                          height: 1.4.h),
                      controller: bioController,
                      focusNode: bioFocusNode,
                    )
                  ],
                ),
              ),
              NextPageButton(
                firstFieldState: true,
                secondFieldState: true,
                text: '편집 완료',
                onPressed: () async {
                  bool userNameValidState = true;
                  if (changedUserName != widget.userName ||
                      changedName != widget.name ||
                      changedBio != widget.bio) {
                    if (widget.userName != changedUserName) {
                      userNameValidState =
                          await ApiService.checkDuplicateUserName(
                              changedUserName);
                    }
                    if (userNameValidState) {
                      await ApiService.updateUserInfo(
                          changedUserName, changedName, '', changedBio);
                      final userInfoProvider =
                          Provider.of<UserInfoProvider>(context, listen: false);

                      await userInfoProvider.fetchUserInfo();
                    }
                  }

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
