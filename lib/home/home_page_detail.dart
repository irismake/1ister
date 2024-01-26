import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lister/home/home_page.dart';
import 'package:lister/model/bottomNavigationBar.dart';

class HomePageDetail extends StatefulWidget {
  HomePageDetail({Key? key}) : super(key: key);

  @override
  State<HomePageDetail> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageDetail> {
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(64.0.h),
          child: AppBar(
            automaticallyImplyLeading: false,
            //backgroundColor: Colors.deepOrange,

            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: SvgPicture.asset(
                    'assets/icons/goBackButton.svg',
                  ),
                ),
                Text(
                  '검색하기',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0.sp,
                  ),
                ),
                Container(
                  child: SvgPicture.asset(
                    'assets/icons/plusButton.svg',
                  ),
                ),
              ],
            ),
            titleSpacing: 16.0.w,
            shape: Border(
              bottom: BorderSide(
                color: Color(0xffb2b2b2),
                width: 1,
              ),
            ),
          ),
        ),
        body: Container());
  }
}
