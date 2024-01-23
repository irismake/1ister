import 'package:flutter/material.dart';

class FileAddPage extends StatefulWidget {
  const FileAddPage({Key? key}) : super(key: key);

  @override
  State<FileAddPage> createState() => _FileAddPageState();
}

class _FileAddPageState extends State<FileAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return  const Text('fileAdd');

          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    ),
    );
  }
}
