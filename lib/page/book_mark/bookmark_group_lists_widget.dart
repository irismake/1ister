import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/my_group_model.dart';
import '../../model/provider/my_groups_provider.dart';
import 'bookmark_list_page.dart';

class BookMarkGroupListsWidget extends StatefulWidget {
  final int groupId;
  const BookMarkGroupListsWidget({Key? key, required this.groupId})
      : super(key: key);

  @override
  State<BookMarkGroupListsWidget> createState() =>
      _BookMarkGroupListsWidgetState();
}

class _BookMarkGroupListsWidgetState extends State<BookMarkGroupListsWidget> {
  late Future<void> _initializeData;

  @override
  void initState() {
    super.initState();
    _initializeData = initializeData();
  }

  Future<void> initializeData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MyGroupsProvider>(context, listen: false);
      provider.bookmarkGroupId = widget.groupId;
      provider.initializeMyGroupData();
      print("f${provider.bookmarkGroupId}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          return Container();
        }
      },
    );
  }
}
