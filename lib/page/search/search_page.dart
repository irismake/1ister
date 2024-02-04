import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/custom/custom_category.dart';
import '../../model/custom/custom_search_bar.dart';
import '../../model/custom_app_bar.dart';
import '../../model/widget/search_list_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? _searchQuery;
  bool _searchState = false;
  List<String> _searchResults = [];
  bool _listState = true;
  bool _itemState = false;
  bool _userState = false;

  void updateSearchResults(String searchTerm) {
    setState(() {
      _searchResults = _generateSearchResults(searchTerm);
    });
  }

  List<String> _generateSearchResults(String searchTerm) {
    List<String> results = [];
    for (int i = 0; i < 10; i++) {
      results.add('Result $i for $searchTerm');
    }
    return results;
  }

  void _onTapList() => _updateCategoryState(true, false, false);
  void _onTapItem() => _updateCategoryState(false, true, false);
  void _onTapUser() => _updateCategoryState(false, false, true);

  void _updateCategoryState(bool list, bool item, bool user) {
    setState(() {
      _listState = list;
      _itemState = item;
      _userState = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        titleText: '검색하기',
        titleState: true,
        actionButtonOnTap: null,
        actionButton: null,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSearchBar(
                onSearch: (String value) {
                  setState(() {
                    _searchQuery = value;
                    updateSearchResults(_searchQuery!);
                    _searchState = true;
                  });
                },
              ),
              _searchState
                  ? Padding(
                      padding: EdgeInsets.only(top: 20.0.h, bottom: 16.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: _onTapList,
                            child: Category(
                              categoryName: 'List',
                              categoryState: _listState,
                            ),
                          ),
                          SizedBox(
                            width: 8.0.w,
                          ),
                          InkWell(
                            onTap: _onTapItem,
                            child: Category(
                              categoryName: 'Item',
                              categoryState: _itemState,
                            ),
                          ),
                          SizedBox(
                            width: 8.0.w,
                          ),
                          InkWell(
                            onTap: _onTapUser,
                            child: Category(
                              categoryName: 'User',
                              categoryState: _userState,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: 20.0.h),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '최근 검색어',
                          style: TextStyle(
                            color: Color(0xFF343A40),
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
              FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Expanded(
                        child: ListView.separated(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            return SearchListWidget(
                                searchWord: _searchResults[index]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              thickness: 1,
                              height: 16.0.h,
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
