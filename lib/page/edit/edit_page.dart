import 'package:flutter/material.dart';
import 'package:lister/model/provider/my_groups_provider.dart';
import 'package:provider/provider.dart';

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
    //_controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _controller = TextfieldTagsController();
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
      body: ChangeNotifierProvider<MyGroupsProvider>(
        create: (context) => MyGroupsProvider(),
        child: EditAddList(),
      ),
    );
  }
}
