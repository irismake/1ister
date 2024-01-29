import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  CustomListView({super.key});

  final List<String> entries = <String>['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        return Container(
          height: 50,
          color: Colors.pink,
          child: Center(child: Text('Entry ${entries[index]}')),
        );
      },
    );
  }
}
