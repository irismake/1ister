import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/provider/create_lists_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyGroupsProvider>(
          create: (context) => MyGroupsProvider(),
        ),
        ChangeNotifierProvider<CreateListsProvider>(
          create: (context) => CreateListsProvider(),
        ),
        ChangeNotifierProvider<KeywordsProvider>(
          create: (context) => KeywordsProvider(),
        ),
      ],
      builder: (context, child) {
        return Scaffold(
          appBar: CustomAppbar(
              popState: true,
              titleText: '리스트 만들기',
              titleState: true,
              actionButtonOnTap: () async {
                // Provider.of<CreateListsProvider>(context, listen: false)
                //         .submittedGroupId =
                //     Provider.of<MyGroupsProvider>(context, listen: false)
                //             .getSelectedGroupId() ??

                String title =
                    Provider.of<CreateListsProvider>(context, listen: false)
                        .submittedTitle;
                String description =
                    Provider.of<CreateListsProvider>(context, listen: false)
                        .submittedDescription;
                String keyword_1 =
                    Provider.of<KeywordsProvider>(context, listen: false)
                        .getKeyword_1();
                String keyword_2 =
                    Provider.of<KeywordsProvider>(context, listen: false)
                        .getKeyword_2();
                bool isPrivate =
                    Provider.of<CreateListsProvider>(context, listen: false)
                        .submittedIsPrivate;
                bool isRankingList =
                    Provider.of<CreateListsProvider>(context, listen: false)
                        .submittedIsRankingList;
                String? imageFilePath =
                    Provider.of<CreateListsProvider>(context, listen: false)
                        .submittedImageFilePath;
                int groupId =
                    Provider.of<MyGroupsProvider>(context, listen: false)
                            .getSelectedGroupId() ??
                        0;
                List<Map<String, dynamic>> items =
                    Provider.of<CreateListsProvider>(context, listen: false)
                        .submittedItems();
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
                Navigator.pop(context, true);
              },
              actionButton: 'button_upload_test'),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: EditAddList(),
          ),
        );
      },
    );
  }
}
