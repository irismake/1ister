import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lister/home/list_detail_page.dart';
import 'package:lister/splash/splash_page.dart';

void main() {
  runApp(
    ScreenUtilInit(
      builder: (BuildContext context, child) => MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xff5BFF7F),
        ),
        home: MyApp(),
        debugShowCheckedModeBanner: false,
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashPage();
  }
}
