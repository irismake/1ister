import 'package:flutter/material.dart';

import '../model/bottom_navigation_bar.dart';
import '../model/list/user_book_mark_list.dart';
import '../model/list/user_my_list.dart';

class UsersListNavigator extends StatefulWidget {
  final bool myListState;

  const UsersListNavigator({Key? key, required this.myListState})
      : super(key: key);

  @override
  State<UsersListNavigator> createState() => _UsersListNavigatorState();
}

class _UsersListNavigatorState extends State<UsersListNavigator> {
  bool homePageState = false;
  final _pages = [
    UserMyList(),
    UserBookMarkList(),
  ];
  final _navigatorKeyList =
      List.generate(2, (index) => GlobalKey<NavigatorState>());

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
        length: 2,
        child: TabBarView(
          children: _pages.map(
            (page) {
              //int index = 0;
              // if (widget.myListState) {
              //   index = 0;
              // } else {
              //   index = 1;
              // }
              int index = _pages.indexOf(page);
              print("user_list_${index}");
              return CustomNavigator(
                page: widget.myListState ? _pages[0] : _pages[1],
                navigatorKey: _navigatorKeyList[index],
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
