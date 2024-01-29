import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lister/model/custom_list_widget.dart';
import 'package:lister/model/custom_tag.dart';
import 'package:lister/model/home_page_navigator.dart';
import 'package:lister/model/custom_app_bar.dart';
import 'package:lister/model/custom_search_bar.dart';
import 'package:lister/page/search/custom_list_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? _searchQuery;
  bool _searchState = false;
  List<String> _searchResults = [];

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
                          Tag(
                            TagName: 'List',
                          ),
                          SizedBox(
                            width: 8.0.w,
                          ),
                          Tag(
                            TagName: 'Item',
                          ),
                          SizedBox(
                            width: 8.0.w,
                          ),
                          Tag(
                            TagName: 'User',
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
                            return ListWidget(
                                searchWord: _searchResults[index]);
                            // return ListTile(
                            //   title: Text(_searchResults[index]),
                            // );
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
