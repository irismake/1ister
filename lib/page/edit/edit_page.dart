import 'package:flutter/material.dart';
import 'package:lister/model/provider/create_lists_provider.dart';
import 'package:lister/services/api_service.dart';
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
          actionButtonOnTap: () {
            // ApiService.createLists();
          },
          actionButton: 'button_upload_test'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ChangeNotifierProvider<CreateListsProvider>(
          create: (context) => CreateListsProvider(),
          child: EditAddList(),
        ),
      ),
    );
  }
}
