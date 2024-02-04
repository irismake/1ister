import 'package:flutter/material.dart';

import '../page/book_mark/bookmark_page.dart';
import '../page/edit/edit_page.dart';
import '../page/home/home_page.dart';
import '../page/search/search_page.dart';
import '../page/user/user_page.dart';
import '../model/custom/custom_icon_button.dart';

class HomePageNavigator extends StatefulWidget {
  HomePageNavigator({Key? key}) : super(key: key);

  @override
  State<HomePageNavigator> createState() => _HomePageNavigatorState();
}

class _HomePageNavigatorState extends State<HomePageNavigator> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  int currentIndex = 0;
  bool homePageState = false;

  final _pages = [
    HomePage(),
    SearchPage(),
    EditPage(),
    BookMarkPage(),
    UserPage(),
  ];
  final _navigatorKeyList =
      List.generate(5, (index) => GlobalKey<NavigatorState>());

  void _pushRoute() {
    _navigatorKey.currentState?.pushNamed(routeC);
    final route = _navigatorKey.currentState;
    print('네이게이터 루트 : $route');
  }

  static const routeA = "/";
  static const routeB = "/B";
  static const routeC = "/C";
  static const routeD = "/D";
  static const routeE = "/E";

  late List<String> route;

  MaterialPageRoute _onGenerateRoute(RouteSettings setting) {
    if (setting.name == routeA) {
      print('page1');
      return MaterialPageRoute<dynamic>(
          builder: (context) => _pages[0], settings: setting);
    } else if (setting.name == routeB) {
      print('page2');
      return MaterialPageRoute<dynamic>(
          builder: (context) => _pages[1], settings: setting);
    } else if (setting.name == routeC) {
      print('page3');
      return MaterialPageRoute<dynamic>(
          builder: (context) => _pages[2], settings: setting);
    } else if (setting.name == routeD) {
      print('page4');
      return MaterialPageRoute<dynamic>(
          builder: (context) => _pages[3], settings: setting);
    } else if (setting.name == routeE) {
      print('page5');
      return MaterialPageRoute<dynamic>(
          builder: (context) => _pages[4], settings: setting);
    } else {
      throw Exception('Unknown route: ${setting.name}');
    }
  }

  @override
  void initState() {
    super.initState();
    route = [routeA, routeB, routeC, routeD, routeE];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          // IOS 뒤로가기 버튼, ButtonWidget이건 뒤로가기 제스쳐가 감지되면 호출 된다.
          print('didPop호출');
          return;
        }
        print('뒤로가기');
      },
      child: DefaultTabController(
        initialIndex: 0,
        length: 5,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Navigator(
            key: _navigatorKeyList[currentIndex],
            initialRoute: route[currentIndex],
            onGenerateRoute: _onGenerateRoute,
          ),
          bottomNavigationBar: BottomAppBar(
            padding: EdgeInsets.only(top: 12.0),
            height: 60.0,
            color: Colors.black,
            child: TabBar(
              dividerHeight: 0,
              indicatorColor: Colors.transparent,
              isScrollable: false,
              onTap: (index) {
                print(index);
                if (index == 0) {
                  _navigatorKeyList[currentIndex]
                      .currentState
                      ?.pushNamed(routeA);
                } else if (index == 1) {
                  _navigatorKeyList[currentIndex]
                      .currentState
                      ?.pushNamed(routeB);
                } else if (index == 2) {
                  _navigatorKeyList[currentIndex]
                      .currentState
                      ?.pushNamed(routeC);
                } else if (index == 3) {
                  _navigatorKeyList[currentIndex]
                      .currentState
                      ?.pushNamed(routeD);
                } else if (index == 4) {
                  _navigatorKeyList[currentIndex]
                      .currentState
                      ?.pushNamed(routeE);
                }
                final route = _navigatorKeyList[currentIndex].currentState;
                print('네이게이터 루트 : $route');
              },
              tabs: <Widget>[
                CustomIconButton(
                  iconName: 'tab_home',
                ),
                CustomIconButton(
                  iconName: 'tab_search',
                ),
                CustomIconButton(
                  iconName: 'tab_edit',
                ),
                CustomIconButton(
                  iconName: 'tab_book_mark',
                ),
                CustomIconButton(
                  iconName: 'tab_user',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
