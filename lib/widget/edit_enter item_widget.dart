import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditEnterItem extends StatefulWidget {
  final int itemNum;
  // final Function(int) onItemNumChanged;

  const EditEnterItem({Key? key, required this.itemNum}) : super(key: key);

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
    final List<int> _items =
        List<int>.generate(widget.itemNum, (int index) => index);

    return ReorderableListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return CustomReorderableDelayedDragStartListener(
          key: Key('$index'),
          delay: const Duration(
              milliseconds: 100), // or any other duration that fits you
          index: _items[index], // passed from parent
          child: ItemWidget(
            key: ValueKey(_items[index]),
          ),
        );
      },
      onReorder: (oldIndex, newIndex) {
        setState(() {
          print('old1 : ${oldIndex}');
          print('new1 : ${newIndex}');
          if (oldIndex < newIndex) {
            newIndex -= 1;
            print('old2 : ${oldIndex}');
            print('new2 : ${newIndex}');
          }
          final int item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
    );
    //     return ReorderableDelayedDragStartListener(
    //       enabled: false,
    //       index: index,
    //       key: Key('$index'),
    //       child: ItemWidget(
    //         key: ValueKey(_items[index]),
    //         index: index,
    //       ),
    //     );
    //   },
    //   onReorder: (oldIndex, newIndex) {
    //     setState(() {
    //       if (oldIndex < newIndex) {
    //         newIndex -= 1;
    //       }
    //       final int item = _items.removeAt(oldIndex);
    //       _items.insert(newIndex, item);
    //     });
    //   },
    // );
  }
}

class CustomReorderableDelayedDragStartListener
    extends ReorderableDragStartListener {
  final Duration delay;

  const CustomReorderableDelayedDragStartListener({
    this.delay = kLongPressTimeout,
    Key? key,
    required Widget child,
    required int index,
    bool enabled = true,
  }) : super(key: key, child: child, index: index, enabled: enabled);

  @override
  MultiDragGestureRecognizer createRecognizer() {
    return DelayedMultiDragGestureRecognizer(delay: delay, debugOwner: this);
  }
}

class ItemWidget extends StatefulWidget {
  const ItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _tagController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _tagController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Container(
        width: double.infinity,
        height: 116.0.h,
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
    );
  }
}
