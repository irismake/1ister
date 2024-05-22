import 'package:flutter/material.dart';

import '../../page/book_mark/bookmark_page.dart';
import '../../page/edit/edit_page.dart';
import '../../page/home/home_page.dart';
import '../../page/search/search_page.dart';
import '../../page/user/user_page.dart';
import '../custom/custom_icon_button.dart';
import 'custom_route_observer.dart';

class HomePageNavigator extends StatefulWidget {
  HomePageNavigator({Key? key}) : super(key: key);

  @override
  State<HomePageNavigator> createState() => _HomePageNavigatorState();
}

class _HomePageNavigatorState extends State<HomePageNavigator> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  int currentIndex = 0;

  final _pages = [
    HomePage(),
    SearchPage(),
    EditPage(),
    BookMarkPage(),
    UserPage(),
  ];

  static const routeA = "/";
  static const routeB = "/search";
  static const routeC = "/edit";
  static const routeD = "/bookmark";
  static const routeE = "/user";

  late List<String> route;

  MaterialPageRoute _onGenerateRoute(RouteSettings setting) {
    if (setting.name == routeA) {
      return MaterialPageRoute<dynamic>(
          builder: (context) => _pages[0], settings: setting);
    } else if (setting.name == routeB) {
      return MaterialPageRoute<dynamic>(
          builder: (context) => _pages[1], settings: setting);
    } else if (setting.name == routeC) {
      return MaterialPageRoute<dynamic>(
          builder: (context) => _pages[2], settings: setting);
    } else if (setting.name == routeD) {
      return MaterialPageRoute<dynamic>(
          builder: (context) => _pages[3], settings: setting);
    } else if (setting.name == routeE) {
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
            key: _navigatorKey,
            initialRoute: route[0],
            onGenerateRoute: _onGenerateRoute,
            observers: [CustomRouteObserver()],
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
                setState(() {
                  if (RouteState().onCurrentRouteChanged == index) {
                    print('같은 페이지');
                    return;
                  }
                  if (index == 0) {
                    _navigatorKey.currentState?.pushNamed(routeA);
                  } else if (index == 1) {
                    _navigatorKey.currentState?.pushNamed(routeB);
                  } else if (index == 2) {
                    _navigatorKey.currentState?.pushNamed(routeC);
                  } else if (index == 3) {
                    _navigatorKey.currentState?.pushNamed(routeD);
                  } else if (index == 4) {
                    _navigatorKey.currentState?.pushNamed(routeE);
                  }
                });
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
