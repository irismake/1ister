import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lister/home/bookmark_page.dart';
import 'package:lister/home/guide_page.dart';
import 'package:lister/home/home_page.dart';
import 'package:lister/home/search_page.dart';
import 'package:lister/home/user_page.dart';
import 'package:lister/model/bottom_navigation_bar.dart';

class HomePageNavigator extends StatefulWidget {
  HomePageNavigator({Key? key}) : super(key: key);

  @override
  State<HomePageNavigator> createState() => _HomePageNavigatorState();
}

class _HomePageNavigatorState extends State<HomePageNavigator> {
  bool homePageState = false;
  final _pages = [
    HomePage(),
    SearchPage(),
    GuidePage(),
    BookmarkPage(),
    UserPage(),
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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        // if (didPop) {
        //   print('return');
        //   return;
        // }
        // print('return');
        // final navigator = Navigator.of(context);
        // bool value = true;
        // if (value) {
        //   navigator.pop();
        // }
      },
      child: DefaultTabController(
        initialIndex: 0,
        length: 5,
        child: Scaffold(
          body: TabBarView(
            children: _pages.map(
              (page) {
                int index = _pages.indexOf(page);
                print(_currentIndex);
                return CustomNavigator(
                  page: page,
                  navigatorKey: _navigatorKeyList[index],
                );
              },
            ).toList(),
          ),
          bottomNavigationBar: CustomBottomAppBar(),
        ),
      ),
    );
  }
}
