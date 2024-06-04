import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../model/provider/create_list_provider.dart';

class EditEnterItem extends StatefulWidget {
  final int itemNum;
  final bool rankingState;

  const EditEnterItem({
    Key? key,
    required this.itemNum,
    required this.rankingState,
  }) : super(key: key);

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
        saveItemsOrder();
      });
    }
  }

  void saveItemsOrder() {
    Provider.of<CreateListProvider>(context, listen: false).itemsOrder = _items;
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
      buildDefaultDragHandles: widget.rankingState,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return widget.rankingState
            ? CustomReorderableDelayedDragStartListener(
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
              )
            : ItemWidget(
                key: ValueKey(_items[index]),
                titleController: _titleControllers[index],
                tagController: _tagControllers[index],
                descriptionController: _descriptionControllers[index],
              );
      },
      onReorder: (oldIndex, newIndex) {
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
        saveItemsOrder();
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
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  late FocusNode _titleFocusNode;
  late FocusNode _descriptionFocusNode;
  late FocusNode _tagFocusNode;
  late int itemKey;

  @override
  void initState() {
    super.initState();
    _titleFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
    _tagFocusNode = FocusNode();
    String keyString = widget.key.toString();
    itemKey = int.tryParse(keyString.replaceAll(RegExp(r'\D'), '')) ?? 0;
    _titleFocusNode.addListener(_onTitleFocusChanged);
    _descriptionFocusNode.addListener(_onDescriptionFocusChanged);
    _tagFocusNode.addListener(_onTagFocusChanged);
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _tagFocusNode.dispose();
    super.dispose();
  }

  void _onTitleFocusChanged() {
    if (!_titleFocusNode.hasFocus) {
      Provider.of<CreateListProvider>(context, listen: false).itemTitles = {
        itemKey: widget.titleController.text
      };
    }
  }

  void _onDescriptionFocusChanged() {
    if (!_descriptionFocusNode.hasFocus) {
      Provider.of<CreateListProvider>(context, listen: false).itemDescriptions =
          {itemKey: widget.descriptionController.text};
    }
  }

  void _onTagFocusChanged() {
    if (!_tagFocusNode.hasFocus) {
      Provider.of<CreateListProvider>(context, listen: false).itemTags = {
        itemKey: widget.tagController.text
      };
    }
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
                  focusNode: _titleFocusNode,
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
                  focusNode: _descriptionFocusNode,
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
                  focusNode: _tagFocusNode,
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
