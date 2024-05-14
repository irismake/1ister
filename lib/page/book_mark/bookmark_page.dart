import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lister/model/provider/user_info_provider.dart';
import 'package:lister/services/api_service.dart';
import 'package:provider/provider.dart';

import '../../model/provider/my_groups_provider.dart';
import '../../widget/custom/custom_next_page_button.dart';
import '../../widget/custom/custom_search_bar.dart';
import '../../widget/custom/custom_text_form_field.dart';
import '../../widget/custom_app_bar.dart';
import 'bookmark_groups_widget.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({Key? key}) : super(key: key);

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  late FocusNode _createGroupFocus;
  String _createdGroupName = '';
  String _username = '';

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _createGroupFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchUserName() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userInfoProvider =
          Provider.of<UserInfoProvider>(context, listen: false);
      userInfoProvider.fetchUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    _username =
        Provider.of<UserInfoProvider>(context, listen: true).userInfo.name;
    void _createGroupDialog(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  color: Colors.white,
                ),
                height: 224.h,
                width: double.infinity,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '그룹 생성',
                            style: TextStyle(
                              fontFamily: 'PretendardRegular',
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              height: 1.2,
                            ),
                          ),
                          InkWell(
                            child: SizedBox(
                              height: 32.0.h,
                              child: SvgPicture.asset(
                                'assets/icons/icon_close_black.svg',
                                fit: BoxFit.contain,
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      CustomTextFormField(
                        hintText: '그룹 이름을 입력해주세요. (최대 30글자)',
                        focusNode: _createGroupFocus,
                        onChanged: (value) {
                          _createdGroupName = value;
                        },
                        keyboardType: TextInputType.name,
                      ),
                      NextPageButton(
                        firstFieldState: true,
                        secondFieldState: true,
                        text: '만들기',
                        onPressed: () async {
                          if (_createdGroupName != '') {
                            await ApiService.createMyGroups(
                                '$_createdGroupName');
                            final myGroupProvider =
                                Provider.of<MyGroupsProvider>(context,
                                    listen: false);
                            myGroupProvider.fetchMyGroups();
                            Navigator.pop(context);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: CustomAppbar(
        popState: true,
        titleText: '${_username}의 북마크',
        titleState: true,
        actionButtonOnTap: () {
          _createGroupDialog(context);
        },
        actionButton: 'button_plus',
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 37.0.h,
          left: 16.0.w,
          right: 16.0.w,
          bottom: 0.0.h,
        ),
        child: Column(
          children: [
            CustomSearchBar(
              autoFocus: false,
              enabled: true,
              onSearch: (String value) {},
            ),
            SizedBox(
              height: 24.0.h,
            ),
            Expanded(
              child: BookMarkGroupsWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
