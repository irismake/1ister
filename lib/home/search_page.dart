import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lister/home/home_page_navigator.dart';
import 'package:lister/model/custom_app_bar.dart';
import 'package:lister/model/custom_search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
        child: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomSearchBar(onTap: null),
                    SizedBox(
                      height: 20.0.h,
                    ),
                    const Align(
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
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
