import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lister/home/bookmark_page.dart';
import 'package:lister/home/file_add_page.dart';
import 'package:lister/home/guide_page.dart';
import 'package:lister/home/search_page.dart';
import 'package:lister/home/user_page.dart';

class CustomIconButton extends StatefulWidget {
  late final String iconName;

  CustomIconButton({
    required this.iconName,

  });

  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override

  void _nextToPage(BuildContext context) {
    // Define a mapping from iconName to the corresponding page
    Map<String, WidgetBuilder> pageMapping = {
      'icon_file_add_light': (context) => FileAddPage(),
      'icon_search_light': (context) => SearchPage(),
      'icon_guide_light': (context) => GuidePage(),
      'icon_bookmark_light': (context) => BookmarkPage(),
      'icon_user_light': (context) => UserPage(),
    };

    // Get the corresponding WidgetBuilder based on the iconName
    WidgetBuilder? builder = pageMapping[widget.iconName];

    if (builder != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text('New Page'),
            ),
            body: builder(context),
            // 아래 부분 추가
            // bottomNavigationBar: BottomAppBar(
            //   child: SizedBox.shrink(), // BottomAppBar를 감춤
            // ),
          ),
        ),
      );
    }


  }



  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        'assets/icons/${widget.iconName}.svg',
        height: 32.0.h,
        width: 32.0.w,
      ),
      onPressed: () {
        _nextToPage(context);

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //     builder: (context) => SetIdNamePage(),
        //     )
        // );
      },
    );
  }
}

