import 'package:flutter/material.dart';
import 'package:lister/page/book_mark/bookmark_page.dart';
import 'package:lister/page/edit/guide_page.dart';
import 'package:lister/page/home/home_page.dart';
import 'package:lister/page/search/search_page.dart';
import 'package:lister/page/user/user_page.dart';
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
                print("iiiii${index}");
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
