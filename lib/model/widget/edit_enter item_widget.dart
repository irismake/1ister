import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:textfield_tags/textfield_tags.dart';

class EditEnterItem extends StatefulWidget {
  final int itemNum;

  const EditEnterItem({super.key, required this.itemNum});

  @override
  State<EditEnterItem> createState() => _EditEnterItemState();
}

class _EditEnterItemState extends State<EditEnterItem> {
  @override
  Widget build(BuildContext context) {
    final List<int> _items = List<int>.generate(10, (int index) => index);
    final List myTiles = [
      'A',
      'B',
      'C',
      'D',
    ];

    return ReorderableListView(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: <Widget>[
        for (int index = 0; index < widget.itemNum; index++)
          MyWidget(
            key: ValueKey(_items[index]),
            index: index,
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                // onReorder 함수를 호출하여 항목을 재정렬
                final int item = _items.removeAt(oldIndex);
                _items.insert(newIndex, item);
              });
            },
          ),
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final int item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
    );
  }
}

class MyWidget extends StatefulWidget {
  final int index;
  final Function(int oldIndex, int newIndex) onReorder;
  MyWidget({super.key, required this.index, required this.onReorder});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  TextfieldTagsController _controller = TextfieldTagsController();
  late double _distanceToField;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          print('길게 누름');
          widget.onReorder(widget.index, 0);
        });
        // 길게 누를 경우 상위 위젯에서 정의한 콜백 함수 호출
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.0.h),
        child: TextFieldTags(
          textfieldTagsController: _controller,
          textSeparators: const [],
          letterCase: LetterCase.normal,
          validator: (String tag) {
            if (tag == 'php') {
              return 'No, please just no';
            } else if (_controller.getTags!.contains(tag)) {
              return 'you already entered that';
            }
            return null;
          },
          inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
            return ((context, sc, tags, onTagDelete) {
              return TextField(
                controller: tec,
                focusNode: fn,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF8F9FA),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: InputBorder.none,
                  // prefixIconConstraints: BoxConstraints(
                  //     maxWidth: _distanceToField * 0.74),
                  prefixIcon: tags.isNotEmpty
                      ? SingleChildScrollView(
                          controller: sc,
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0.h, horizontal: 16.0.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '합정 최강금돈까스',
                                  style: TextStyle(
                                    color: Color(0xFF343A40),
                                    fontSize: 16.sp,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w700,
                                    height: 1.5.h,
                                  ),
                                ),
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: tags.map((String tag) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 4.0.h,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '$tag',
                                                  style: TextStyle(
                                                      color: Color(0xff495057),
                                                      height: 1.5.h),
                                                ),
                                                InkWell(
                                                  child: SizedBox(
                                                    height: 24.0.h,
                                                    child: SvgPicture.asset(
                                                      'assets/icons/icon_close.svg',
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    onTagDelete(tag);
                                                  },
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList()),
                              ],
                            ),
                          ),
                        )
                      : null,
                ),
                onChanged: onChanged,
                onSubmitted: onSubmitted,
              );
            });
          },
        ),
      ),
    );
  }
}
