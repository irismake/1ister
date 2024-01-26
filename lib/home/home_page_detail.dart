import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lister/home/home_page.dart';
import 'package:lister/model/bottom_navigation_bar.dart';
import 'package:lister/model/custom_app_bar.dart';

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
        appBar:
            CustomAppbar(titleText: '', titleState: false, actionButton: ''),
        body: Container());
  }
}
