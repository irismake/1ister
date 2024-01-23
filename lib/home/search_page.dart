import 'package:flutter/material.dart';
import 'package:lister/home/home_page_navigator.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
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
