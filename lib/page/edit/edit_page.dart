import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/provider/create_list_provider.dart';
import '../../model/provider/keywords_provider.dart';
import '../../model/provider/my_groups_provider.dart';
import '../../services/api_service.dart';
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
          actionButtonOnTap: () async {
            String title =
                Provider.of<CreateListProvider>(context, listen: false)
                    .submittedTitle;
            String description =
                Provider.of<CreateListProvider>(context, listen: false)
                    .submittedDescription;
            String keyword_1 =
                Provider.of<KeywordsProvider>(context, listen: false)
                    .getKeyword_1();
            String keyword_2 =
                Provider.of<KeywordsProvider>(context, listen: false)
                    .getKeyword_2();
            bool isPrivate =
                Provider.of<CreateListProvider>(context, listen: false)
                    .submittedIsPrivate;
            bool isRankingList =
                Provider.of<CreateListProvider>(context, listen: false)
                    .submittedIsRankingList;
            String? imageFilePath =
                Provider.of<CreateListProvider>(context, listen: false)
                    .submittedImageFilePath;
            int groupId = Provider.of<MyGroupsProvider>(context, listen: false)
                    .getSelectedGroupId() ??
                0;
            List<int> order =
                Provider.of<CreateListProvider>(context, listen: false)
                    .itemsOrder;
            List<Map<String, dynamic>> items =
                Provider.of<CreateListProvider>(context, listen: false)
                    .submittedItems(order);
            print('아이템$items');

            await ApiService.createLists(
              title,
              description,
              keyword_1,
              keyword_2,
              isPrivate,
              isRankingList,
              imageFilePath,
              groupId,
              items,
            );
            Navigator.pop(context);
          },
          actionButton: 'button_upload_test'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: EditAddList(),
      ),
    );
  }
}
