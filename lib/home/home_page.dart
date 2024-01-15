import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    // MySellPostPage(),
    // MyPostPage(),
    // MyPage(),
  ];

  @override
  void initState() {
    //해당 클래스가 호출되었을떄
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
            toolbarHeight: 64.0.h + MediaQuery.of(context).padding.top,
            //backgroundColor: Colors.green,
            elevation: 0,
            leadingWidth: 100,
            leading: Padding(
              padding: EdgeInsets.only(top: 16.0.h , left: 16.0.w),
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

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 176.0.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '궁금한 리스트를\n검색해보세요.',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 28.0.sp,
                        ),
                      ),
                    ),
                    Container(
                      height: 48.0.h,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        color: Color(0xffF5F6F7),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //color: Colors.green,
                height: 352.0.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
      
                      height: 42.0.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '지금 핫한 리스트',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0.sp,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  print('더보기');
                                },
                                child: Text(
                                  '더보기',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0.sp,
                                    color: Color(0xff868E96),
                                  ),
                                ),
                              )
      
                              // Text(
                              //   '지금 핫한 리스트',
                              //   style: TextStyle(
                              //     fontWeight: FontWeight.w700,
                              //     fontSize: 18.0.sp,
                              //   ),
                              // ),
                            ],
                          ),
                           Divider(
                            color: Colors.black,
                            height: 2.0.h,
                            thickness: 2.0.h,
      
                            // indent: 0,
                            // endIndent: 0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.pink,
                      height: 282.0.h,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Container(
            height: 60.0.h,
            child: Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/icons/icon_file_add_light.svg',
                      height: 32.0.h,
                      width: 32.0.w,
                    ),
                    SvgPicture.asset(
                      'assets/icons/icon_search_light.svg',
                      height: 32.0.h,
                      width: 32.0.w,
                    ),
                    SvgPicture.asset(
                      'assets/icons/icon_guide_light.svg',
                      height: 32.0.h,
                      width: 32.0.w,
                    ),
                    SvgPicture.asset(
                      'assets/icons/icon_bookmark_light.svg',
                      height: 32.0.h,
                      width: 32.0.w,
                    ),
                    SvgPicture.asset(
                      'assets/icons/icon_user_light.svg',
                      height: 32.0.h,
                      width: 32.0.w,
                    ),
                  ]),
            ),
          ),
        ),

    );
  }
}
