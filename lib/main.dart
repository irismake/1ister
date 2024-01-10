import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'home/home_page.dart';
import 'login/login_page.dart';

void main() {
  runApp(
    ScreenUtilInit(
      builder: (BuildContext context, child) => MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xff5BFF7F),
        ),
        home: MyApp(),
      ),
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = FlutterSecureStorage();
  String? authToken;

  @override
  void initState() {
    super.initState();
    _loadAuthToken(context);
  }

  Future<void> _loadAuthToken(BuildContext context) async {
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
        MaterialPageRoute(builder: (context) => HomePage()),
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
          'assets/images/Logo_Name.svg',
          height: 144.0.h,
          width: 40.0.w,
        ),
      ),
    );
  }
}
