import 'dart:convert';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import '../../model/lists.dart';
import '../../services/provider/list_provider.dart';

class HomeListView extends StatelessWidget {
  HomeListView({super.key});
  late List<MainListData> mainLists;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainListsProvider>(
      builder: (context, provider, child) {
        mainLists = provider.mainLists();
        print(mainLists);
        return ListView.builder(
          itemCount: mainLists.length,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.deepOrange,
              padding: const EdgeInsets.all(15),
              child: Text(
                '${utf8.decode(mainLists[index].title.runes.toList())}',
                style: TextStyle(color: Colors.black),
              ),
            );
          },
        );
      },
    );
  }
}
