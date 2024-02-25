import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lister/services/api_service.dart';

import '../../widget/custom/custom_next_page_button.dart';
import '../../widget/custom/custom_text_field.dart';
import '../../widget/custom_app_bar.dart';

class UserEditInfoPage extends StatefulWidget {
  final String userName;
  final String name;
  final String? bio;
  final String picture;

  UserEditInfoPage({
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    userNameController.text = widget.userName;
    nameController.text = widget.name;
    bioController.text = widget.bio!;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    userNameController.dispose();
    nameController.dispose();
    bioController.dispose();
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
          titleText: '계정 편집',
          titleState: true,
          actionButtonOnTap: () {},
          actionButton: null,
        ),
        body: Form(
          key: formKey,
          child: Padding(
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
                            fontFamily: 'PretendardRegular',
                            fontSize: 16.sp,
                            color: Color(0xff868E96),
                            fontWeight: FontWeight.w700,
                            height: 1.5.h),
                        controller: userNameController,
                      ),
                      CustomTextField(
                        prefixState: false,
                        labelState: true,
                        labelText: '이름',
                        height: 88.0.h,
                        fieldHeight: 56.0.h,
                        textStyle: TextStyle(
                            fontFamily: 'PretendardRegular',
                            fontSize: 16.sp,
                            color: Color(0xff343A40),
                            fontWeight: FontWeight.w700,
                            height: 1.5.h),
                        controller: nameController,
                      ),
                      CustomTextField(
                        prefixState: false,
                        labelState: true,
                        labelText: '사용자 소개',
                        height: 127.0.h,
                        fieldHeight: 95.0.h,
                        textStyle: TextStyle(
                            fontFamily: 'PretendardRegular',
                            fontSize: 14.sp,
                            color: Color(0xff343A40),
                            fontWeight: FontWeight.w500,
                            height: 1.4.h),
                        controller: bioController,
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
                    final formKeyState = formKey.currentState!;
                    formKeyState.save();
                    String changedUserName = userNameController.text;
                    String changedName = nameController.text;
                    String changedBio = bioController.text;
                    if (widget.userName != changedUserName) {
                      userNameValidState =
                          await ApiService.checkDuplicateUserName(
                              changedUserName);
                    }
                    if (await ApiService.updateUserInfo(
                            changedUserName, changedName, '', changedBio) &&
                        userNameValidState == true) {
                      Navigator.pop(context, true);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
