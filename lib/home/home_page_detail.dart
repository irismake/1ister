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
        appBar: AppBar(
          toolbarHeight: 64.0.h + MediaQuery.of(context).padding.top,
          elevation: 0,
          leadingWidth: 100,
          leading: Padding(
            padding: EdgeInsets.only(top: 16.0.h, left: 16.0.w),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                color: Colors.purple,
                icon: Icon(Icons.arrow_back)),
          ),
          shape: Border(
            bottom: BorderSide(
              color: Color(0xffb2b2b2),
              width: 1,
            ),
          ),
        ),
        body: Container());
  }
}
