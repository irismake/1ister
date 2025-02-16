import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../components/navigator/home_page_navigator.dart';
import '../login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final storage = FlutterSecureStorage();
  String? accessToken;

  @override
  void initState() {
    super.initState();
    _getAccessToken(context);
  }

  Future<void> _getAccessToken(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    accessToken = await storage.read(key: 'ACCESS_TOKEN');
    if (_isTokenValid(accessToken)) {
      print(accessToken);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePageNavigator()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  bool _isTokenValid(String? accessToken) {
    if (accessToken == null) {
      return false;
    }
    Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
    if (decodedToken == null) {
      return false;
    }
    DateTime expiry =
        DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
    print(expiry.isAfter(DateTime.now()));
    return expiry.isAfter(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(
          left: 123.0.w,
          top: 376.0.h,
          right: 123.0.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/image_logo_name.svg',
              width: 144.0.w,
              height: 40.0.h,
            ),
          ],
        ),
      ),
    );
  }
}
