import 'package:flutter/material.dart';
import 'package:lister/home/home_page_navigator.dart';
import 'package:lister/model/custom_app_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          titleText: '검색하기', titleState: false, actionButton: null),
      body: Center(
        child: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container();
              // return  ElevatedButton(
              //   child: Text("open page2"),
              //   onPressed: () {
              //     Navigator.pop(
              //       context,
              //       MaterialPageRoute(builder: (context) => HomePageNavigator()),
              //     );
              //   },
              // );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
