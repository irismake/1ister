import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lister/home/bookmark_page.dart';
import '../model/icon_button.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> pages = [

    BookmarkPage(),

  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64.0.h + MediaQuery.of(context).padding.top,
        elevation: 0,
        leadingWidth: 100,
        leading: Padding(
          padding: EdgeInsets.only(top: 16.0.h, left: 16.0.w),
          child: SvgPicture.asset(
            'assets/images/Logo_Name.svg',
            height: 24.0.h,
            width: 86.4.w,
          ),
        ),
        shape: Border(
          bottom: BorderSide(
            color: Color(0xffb2b2b2),
            width: 1,
          ),
        ),
      ),
      body: pages[_currentIndex],

      bottomNavigationBar:
      BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 60.0.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIconButton(
                iconName:  'icon_file_add_light',
              ),
              CustomIconButton(
                iconName: 'icon_search_light',
              ),
              CustomIconButton(
                iconName:  'icon_guide_light',
              ),
              CustomIconButton(
                iconName: 'icon_bookmark_light',
              ),
              CustomIconButton(
                iconName: 'icon_user_light',
              ),
            ],
          ),
        ),

      ),

    );
  }
}
