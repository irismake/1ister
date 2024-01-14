import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 60.0.h,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 32.0.h,
                  // child:  Image.asset(
                  //   'assets/icons/icon_file_add_light.svg',
                  //   width: 18.w,
                  //   height: 18.33.h,
                  //
                  // ),
                ),

              ]),
        ),
      ),
    );
  }
}
