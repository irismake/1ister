import 'package:flutter/material.dart';
import 'package:lister/page/book_mark/bookmark_page.dart';
import 'package:lister/page/edit/edit_page.dart';
import 'package:lister/page/home/home_page.dart';
import 'package:lister/page/search/search_page.dart';
import 'package:lister/page/user/user_page.dart';
import 'package:lister/model/bottom_navigation_bar.dart';

const routeA = "/";
const routeB = "/B";
const routeC = "/C";
const routeD = "/D";
const routeE = "/E";

class HomePageNavigator extends StatefulWidget {
  HomePageNavigator({Key? key}) : super(key: key);

  @override
  State<HomePageNavigator> createState() => _HomePageNavigatorState();
}

class _HomePageNavigatorState extends State<HomePageNavigator> {
  int currentIndex = 0;
  bool homePageState = false;

  final _pages = [
    HomePage(),
    SearchPage(),
    EditPage(),
    BookmarkPage(),
    UserPage(),
  ];
  final _navigatorKeyList =
      List.generate(5, (index) => GlobalKey<NavigatorState>());

  void _pushRoute() {
    _navigatorKeyList[currentIndex].currentState?.pushNamed(routeB);
    final route = _navigatorKeyList[currentIndex].currentState;
    print('네이게이터 루트 : $route');
  }

  MaterialPageRoute _onGenerateRoute(RouteSettings setting) {
    if (setting.name == routeA) {
      print('page1');
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
          body: TabBarView(
            children: _pages.map(
              (page) {
                int index = _pages.indexOf(page);
                currentIndex = index;
                print("iiiii${currentIndex}");
                return Navigator(
                  key: _navigatorKeyList[index],
                  initialRoute: routeA,
                  onGenerateRoute: _onGenerateRoute,
                );
              },
            ).toList(),
          ),
          bottomNavigationBar: CustomBottomAppBar(
            onPress: _pushRoute,
          ),
        ),
      ),
    );
  }
}
