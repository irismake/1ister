import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lister/page/list_detail_page.dart';
import '../../model/home_page_navigator.dart';
import '../login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final storage = FlutterSecureStorage();
  String? authToken;

  @override
  void initState() {
    super.initState();
    _getAccessToken(context);
  }

  Future<void> _getAccessToken(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));

    final accessToken = await storage.read(key: 'ACCESS_TOKEN');
    final dio = Dio();
    print("access Token :$accessToken");
    _handleNavigation(context, accessToken);
  }

  void _handleNavigation(BuildContext context, String? accessToken) {
    if (accessToken == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      print('no access token');
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePageNavigator()),
      );
      print('have access token');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(123.0.w, 376.0.h, 123.0.w, 428.0.h),
        child: SvgPicture.asset(
          'assets/images/image_logo_name.svg',
          height: 144.0.h,
          width: 40.0.w,
        ),
      ),
    );
  }
}
