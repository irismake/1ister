import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lister/home/bookmark_page.dart';
import 'package:lister/home/file_add_page.dart';
import 'package:lister/home/guide_page.dart';
import 'package:lister/home/search_page.dart';
import 'package:lister/home/user_page.dart';
import '../model/icon_button.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pages = const [
    FileAddPage(),
    SearchPage(),
    GuidePage(),
    BookmarkPage(),
    UserPage()
  ];
  final _navigatorKeyList =
      List.generate(5, (index) => GlobalKey<NavigatorState>());
  int _currentIndex = 0;

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
    return  DefaultTabController(
        length: 5,
        child: Scaffold(
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
          body: TabBarView(
            children: _pages.map(
              (page) {
                int index = _pages.indexOf(page);
                return CustomNavigator(
                  page: page,
                  navigatorKey: _navigatorKeyList[index],
                );
              },
            ).toList(),
          ),
          bottomNavigationBar: BottomAppBar(

            padding: EdgeInsets.only(top:12.0.h),
              height: 60.0.h,
              color: Colors.black,
              child:  TabBar(
                dividerHeight: 0,
                indicatorColor: Colors.transparent,
                  isScrollable: false,
                  onTap: (index) => setState(() {
                    _currentIndex = index;
                  }),
                  tabs: <Widget>[
                    CustomIconButton(
                      iconName: 'icon_file_add_light',
                    ),
                    CustomIconButton(
                      iconName: 'icon_search_light',
                    ),
                    CustomIconButton(
                      iconName: 'icon_guide_light',
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

    // BottomAppBar(
    //   color: Colors.black,
    //   child: Container(
    //     height: 60.0.h,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         CustomIconButton(
    //           iconName:  'icon_file_add_light',
    //         ),
    //         CustomIconButton(
    //           iconName: 'icon_search_light',
    //         ),
    //         CustomIconButton(
    //           iconName:  'icon_guide_light',
    //         ),
    //         CustomIconButton(
    //           iconName: 'icon_bookmark_light',
    //         ),
    //         CustomIconButton(
    //           iconName: 'icon_user_light',
    //         ),
    //       ],
    //     ),
    //   ),
    //
    // ),
    //
    //     ),
    //   ),
    // );
  }
}

class CustomNavigator extends StatefulWidget {
  final Widget page;
  final Key navigatorKey;
  const CustomNavigator(
      {Key? key, required this.page, required this.navigatorKey})
      : super(key: key);

  @override
  _CustomNavigatorState createState() => _CustomNavigatorState();
}

class _CustomNavigatorState extends State<CustomNavigator>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (_) =>
          MaterialPageRoute(builder: (context) => widget.page),
    );
  }
}
