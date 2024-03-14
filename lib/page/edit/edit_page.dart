import 'package:flutter/material.dart';

import '../../widget/custom_app_bar.dart';
import 'edit_add_list.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          popState: true,
          titleText: '리스트 만들기',
          titleState: true,
          actionButtonOnTap: () {},
          actionButton: null),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: EditAddList(),
      ),
    );
  }
}
