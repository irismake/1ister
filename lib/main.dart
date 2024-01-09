import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lister/home/home_page.dart';

import 'login/login_page.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
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
    final accessToken = await storage.read(key: 'ACCESS_TOKEN');
    //final refreshToken = await storage.read(key: 'REFRESH_TOKEN');
    final dio = Dio();
    print("access Token :$accessToken");
    _handleNavigation(context, accessToken);
  }

  void _handleNavigation(BuildContext context, String? accessToken) {
    if (accessToken == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      print('no access token');
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      print('have access token');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}