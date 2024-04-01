import 'package:flutter/material.dart';

import '../list/user_book_mark_list.dart';
import '../list/user_my_list.dart';

class UsersListNavigator extends StatefulWidget {
  final bool myListState;
  final void Function(int) onPageChanged;

  const UsersListNavigator({
    Key? key,
    required this.myListState,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  State<UsersListNavigator> createState() => _UsersListNavigatorState();
}

class _UsersListNavigatorState extends State<UsersListNavigator> {
  late int selectedPage;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    selectedPage = widget.myListState ? 1 : 0;
    _pageController = PageController(initialPage: selectedPage);
  }

  @override
  void didUpdateWidget(UsersListNavigator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.myListState != widget.myListState) {
      selectedPage = widget.myListState ? 1 : 0;
      _pageController.jumpToPage(selectedPage);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (page) {
        setState(() {
          selectedPage = page;
        });
        widget.onPageChanged(page);
      },
      children: List.generate(2, (index) {
        return index == 0 ? UserMyList() : UserBookMarkList();
      }),
    );

    // PageView.builder(
    //   controller: _pageController,
    //   itemCount: 2,
    //   itemBuilder: (context, index) {
    //     return index == 0 ? UserMyList() : UserBookMarkList();
    //   },
    // );
  }
}
