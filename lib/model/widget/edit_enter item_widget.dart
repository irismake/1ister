import 'package:flutter/material.dart';

class EditEnterItem extends StatefulWidget {
  const EditEnterItem({super.key});

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

    void updateMyTiles(int oldIndex, int newIndex) {
      setState(() {
        // this adjustment is needed when moving down the list
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }

        // get the tile we are moving
        final String tile = myTiles.removeAt(oldIndex);
        // place the tile in new position
        myTiles.insert(newIndex, tile);
      });
    }

    return ReorderableListView(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: <Widget>[
        for (int index = 0; index < _items.length; index++)
          ListTile(
            key: Key('$index'),
            //tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
            title: Text('Item ${_items[index]}'),
            trailing: Icon(Icons.drag_handle),
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
