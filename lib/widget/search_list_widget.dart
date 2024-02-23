import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'custom/custom_follow_button.dart';
import 'custom/custom_keyword.dart';

class ListViewWidget extends StatefulWidget {
  final List<dynamic> userInfo;
  final String? searchText;
  final bool listState;
  final bool itemState;
  final bool userState;

  const ListViewWidget(
      {super.key,
      required this.userInfo,
      required this.searchText,
      required this.listState,
      required this.itemState,
      required this.userState});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  // List<String> _searchResults = [];

  // void updateSearchResults(String searchTerm) {
  //   setState(() {
  //     _searchResults = _generateSearchResults(searchTerm);
  //     print(_searchResults);
  //   });
  // }

  // List<String> _generateSearchResults(String searchTerm) {
  //   List<String> results = [];
  //   for (int i = 0; i < 10; i++) {
  //     results.add('Result $i for $searchTerm');
  //   }
  //   return results;
  // }

  final List<String> list = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P'
  ];

  Widget buildListWidget(int index) {
    final Map<bool, Widget> widgetMap = {
      widget.listState: SearchListWidget(searchText: widget.searchText),
      widget.itemState: SearchItemWidget(searchText: widget.searchText),
      widget.userState: SearchUserWidget(userInfo: widget.userInfo[index]),
    };

    return widgetMap.entries.firstWhere((entry) => entry.key).value;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: widget.userInfo.length,
      itemBuilder: (context, index) {
        return buildListWidget(index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Color(0xffDEE2E6),
          thickness: 1,
          height: 16.0,
        );
      },
    );
  }
}

class SearchListWidget extends StatelessWidget {
  final String? searchText;

  const SearchListWidget({required this.searchText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 154.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 88.0,
                height: 110.0,
                decoration: ShapeDecoration(
                  color: Color(0xFFF1F3F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$searchText',
                      style: TextStyle(
                        color: Color(0xFF343A40),
                        fontSize: 18,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 1.6,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6.0, bottom: 16.0),
                      child: KeyWord(keyWordName: '키워드'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '부지런한 아보카도',
                          style: TextStyle(
                            color: Color(0xFF868E96),
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '23.09.13',
                          style: TextStyle(
                            color: Color(0xFF868E96),
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/button_book_mark.svg',
              width: 32.0,
              height: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchItemWidget extends StatelessWidget {
  final String? searchText;

  const SearchItemWidget({required this.searchText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 112.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 80.0,
                height: 80.0,
                decoration: ShapeDecoration(
                  color: Color(0xFFF1F3F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$searchText',
                      style: TextStyle(
                        color: Color(0xFF343A40),
                        fontSize: 18,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: KeyWord(keyWordName: '키워드'),
                    ),
                  ],
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/button_book_mark.svg',
              width: 32.0,
              height: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchUserWidget extends StatelessWidget {
  final Map<String, dynamic> userInfo;

  const SearchUserWidget({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 66.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/image_user_profile.svg',
              width: 40.0,
              height: 40.0,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${utf8.decode(userInfo['name'].toString().codeUnits)}',
                      style: TextStyle(
                        color: Color(0xFF343A40),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      '${utf8.decode(userInfo['bio'].toString().codeUnits)}',
                      style: TextStyle(
                        color: Color(0xFF868E96),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ],
                ),
              ),
            ),
            CustomFollowButton(),
          ],
        ),
      ),
    );
  }
}
