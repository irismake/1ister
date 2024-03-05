import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditEnterItem extends StatefulWidget {
  final int itemNum;
  final Function(int) onItemNumChanged;

  const EditEnterItem(
      {Key? key, required this.itemNum, required this.onItemNumChanged})
      : super(key: key);

  @override
  _EditEnterItemState createState() => _EditEnterItemState();
}

class _EditEnterItemState extends State<EditEnterItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<int> _items = List<int>.generate(10, (int index) => index);
    final List myTiles = [
      'A',
      'B',
      'C',
      'D',
    ];

    return ReorderableListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return ReorderableDragStartListener(
          index: index,
          key: Key('$index'),
          child: ItemWidget(
            key: ValueKey(_items[index]),
            index: index,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                final int item = _items.removeAt(oldIndex);
                _items.insert(newIndex, item);
              });
            },
          ),
        );
      },
      onReorder: (oldIndex, newIndex) {
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

class ItemWidget extends StatefulWidget {
  final int index;
  final Function(int oldIndex, int newIndex) onReorder;

  const ItemWidget({
    Key? key,
    required this.index,
    required this.onReorder,
  }) : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          widget.onReorder(widget.index, 0);
          print('길게 누름');
        });
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.0),
        child: Container(
          width: double.infinity,
          height: 116.0,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Color(0xffF8F9FA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _titleController,
                    expands: false,
                    style: TextStyle(
                      decorationThickness: 0,
                      color: Color(0xff343A40),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '합정 최강금돈까스',
                      hintStyle: TextStyle(
                        color: Color(0xffADB5BD),
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _descriptionController,
                    style: TextStyle(
                      decorationThickness: 0,
                      color: Color(0xff495057),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '아침에 가서 웨이팅 해야함',
                      hintStyle: TextStyle(
                        color: Color(0xffADB5BD),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                      suffixIcon: InkWell(
                        child: SizedBox(
                          height: 24.0,
                          child: SvgPicture.asset(
                            'assets/icons/icon_close.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        onTap: () {
                          _descriptionController.clear();
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _tagController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '#지리산돈까스 #전통주판매',
                      hintStyle: TextStyle(
                        color: Color(0xffADB5BD),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                      suffixIcon: InkWell(
                        child: SizedBox(
                          height: 24.0,
                          child: SvgPicture.asset(
                            'assets/icons/icon_close.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        onTap: () {
                          _tagController.clear();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
