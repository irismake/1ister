import 'package:flutter/material.dart';
import 'package:lister/model/icon_button.dart';

class CustomBottomAppBar extends StatelessWidget {
  final Function onPress;
  CustomBottomAppBar({Key? key, required this.onPress}) : super(key: key);
  bool state = false;

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
          print(index);
          onPress;
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
    print("navigatorKey:${widget.navigatorKey}");
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (_) =>
          MaterialPageRoute(builder: (context) => widget.page),
    );
  }
}
