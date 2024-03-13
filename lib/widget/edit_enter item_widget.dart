import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditEnterItem extends StatefulWidget {
  final int itemNum;

  const EditEnterItem({Key? key, required this.itemNum}) : super(key: key);

  @override
  _EditEnterItemState createState() => _EditEnterItemState();
}

class _EditEnterItemState extends State<EditEnterItem> {
  List<int> _items = [];
  late List<TextEditingController> _titleControllers = [];
  late List<TextEditingController> _descriptionControllers = [];
  late List<TextEditingController> _tagControllers = [];

  @override
  void initState() {
    super.initState();
    _items = List<int>.generate(widget.itemNum, (int index) => index);
    _titleControllers = List.generate(
      widget.itemNum,
      (index) => TextEditingController(),
    );
    _descriptionControllers = List.generate(
      widget.itemNum,
      (index) => TextEditingController(),
    );
    _tagControllers = List.generate(
      widget.itemNum,
      (index) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.itemNum; i++) {
      _titleControllers[i];
      _descriptionControllers[i];
      _tagControllers[i];
    }
    print('dispose');
    super.dispose();
  }

  @override
  void didUpdateWidget(EditEnterItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.itemNum != oldWidget.itemNum) {
      setState(() {
        print('this');
        _items.add(widget.itemNum - 1);
        _titleControllers.add(TextEditingController());
        _descriptionControllers.add(TextEditingController());
        _tagControllers.add(TextEditingController());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      proxyDecorator: (child, index, animation) {
        return Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: animation.drive(
              Tween<double>(begin: 1, end: 1.1).chain(
                CurveTween(curve: Curves.linear),
              ),
            ),
            child: child,
          ),
        );
      },
      buildDefaultDragHandles: true,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return CustomReorderableDelayedDragStartListener(
          key: Key('$index'),
          delay: const Duration(
            milliseconds: 150,
          ),
          index: index,
          child: ItemWidget(
            key: ValueKey(_items[index]),
            titleController: _titleControllers[index],
            tagController: _tagControllers[index],
            descriptionController: _descriptionControllers[index],
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
          final titleController = _titleControllers.removeAt(oldIndex);
          _titleControllers.insert(newIndex, titleController);
          final descriptionController =
              _descriptionControllers.removeAt(oldIndex);
          _descriptionControllers.insert(newIndex, descriptionController);
          final tagController = _tagControllers.removeAt(oldIndex);
          _tagControllers.insert(newIndex, tagController);
          print('${_items}');
        });
      },
    );
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
    print(index);
    return DelayedMultiDragGestureRecognizer(delay: delay, debugOwner: this);
  }
}

class ItemWidget extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController tagController;
  const ItemWidget(
      {Key? key,
      required this.titleController,
      required this.descriptionController,
      required this.tagController})
      : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
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
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    setState(() {
                      print(value);
                    });
                  },
                  controller: widget.titleController,
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
                    hintText: '합정 최강금돈까스+${widget.key}',
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
                  controller: widget.descriptionController,
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
                        widget.descriptionController.clear();
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: widget.tagController,
                  style: TextStyle(
                    decorationThickness: 0,
                    color: Color(0xff495057),
                    fontSize: 12,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
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
                        widget.tagController.clear();
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
