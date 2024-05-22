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

  final _pages = [
    HomePage(),
    SearchPage(),
    EditPage(),
    BookMarkPage(),
    UserPage(),
  ];

  static const List<String> _routeNames = [
    '/',
    '/search',
    '/edit',
    '/bookmark',
    '/user',
  ];

  MaterialPageRoute _onGenerateRoute(RouteSettings settings) {
    final index = _routeNames.indexOf(settings.name!);
    if (index != -1) {
      return MaterialPageRoute(
        builder: (context) => _pages[index],
        settings: settings,
      );
    } else {
      throw Exception('Unknown route: ${settings.name}');
    }
  }

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
            initialRoute: _routeNames[0],
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
                  _navigatorKey.currentState?.pushNamed(_routeNames[index]);
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
