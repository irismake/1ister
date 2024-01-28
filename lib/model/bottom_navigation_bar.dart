import 'package:flutter/material.dart';
import 'package:lister/model/icon_button.dart';

class CustomBottomAppBar extends StatelessWidget {
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
    print("navigatorKey:${widget.navigatorKey}");
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (_) =>
          MaterialPageRoute(builder: (context) => widget.page),
    );
  }
}
