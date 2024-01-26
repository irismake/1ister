import 'package:flutter/material.dart';
import 'package:lister/home/home_page_detail.dart';
import 'package:lister/home/home_page_navigator.dart';
import 'package:lister/model/icon_button.dart';
import 'package:lister/home/bookmark_page.dart';
import 'package:lister/home/file_add_page.dart';
import 'package:lister/home/guide_page.dart';
import 'package:lister/home/search_page.dart';
import 'package:lister/home/user_page.dart';

class CustomBottomAppBar extends StatelessWidget {
  bool state = false;
  final _pages = [
    FileAddPage(),
    SearchPage(),
    GuidePage(),
    BookmarkPage(),
    UserPage(),
  ];
  final _navigatorKeyList =
      List.generate(5, (index) => GlobalKey<NavigatorState>());
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: EdgeInsets.only(top: 12.0),
      height: 60.0,
      color: Colors.black,
      child: TabBar(
        dividerHeight: 0,
        indicatorColor: Colors.transparent,
        isScrollable: false,
        onTap: (index) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => HomePageNavigator()),
          // );
        },
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
    );
  }
}

class CustomNavigator extends StatefulWidget {
  final Widget page;
  final Key navigatorKey;

  const CustomNavigator({
    Key? key,
    required this.page,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  _CustomNavigatorState createState() => _CustomNavigatorState();
}

class _CustomNavigatorState extends State<CustomNavigator>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (_) =>
          MaterialPageRoute(builder: (context) => widget.page),
    );
  }
}
