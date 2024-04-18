import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'model/provider/create_list_provider.dart';
import 'model/provider/follows_provider.dart';
import 'model/provider/keywords_provider.dart';
import 'model/provider/get_lists_provider.dart';
import 'model/provider/my_groups_provider.dart';
import 'model/provider/user_info_provider.dart';
import 'page/splash/splash_page.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider<MyGroupsProvider>(
            create: (context) => MyGroupsProvider(),
          ),
          ChangeNotifierProvider<CreateListProvider>(
            create: (context) => CreateListProvider(),
          ),
          ChangeNotifierProvider<KeywordsProvider>(
            create: (context) => KeywordsProvider(),
          ),
          ChangeNotifierProvider<GetListsProvider>(
            create: (context) => GetListsProvider(),
          ),
          ChangeNotifierProvider<FollowsProvider>(
            create: (context) => FollowsProvider(),
          ),
          ChangeNotifierProvider<UserInfoProvider>(
            create: (context) => UserInfoProvider(),
          ),
        ],
        builder: (context, child) {
          return ScreenUtilInit(
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
          );
        }),
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
