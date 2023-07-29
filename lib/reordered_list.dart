import 'package:flutter/material.dart';

class ReOrderableList extends StatefulWidget {
  const ReOrderableList({
    super.key,
  });

  @override
  State<ReOrderableList> createState() => _ReOrderableListState();
}

class _ReOrderableListState extends State<ReOrderableList> {
  List<Widget> widgetList = [
    for (int i = 0; i < 50; i++)
      Padding(
        padding: EdgeInsets.all(10),
        key: ValueKey(i),
        child: Container(
          alignment: Alignment.center,
          height: 70,
          decoration: BoxDecoration(
              color: i % 2 == 0 ? Colors.blueGrey : Colors.blueGrey.shade100,
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            'Value: $i',
            style: TextStyle(
                color: i % 2 == 0 ? Colors.blueGrey.shade100 : Colors.blueGrey,
                fontSize: 28),
          ),
        ),
      )
  ];
  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
        key: UniqueKey(),
        padding: EdgeInsets.all(10),
        footer: const ListRepresentingText(
          text: 'Bs Meri!',
        ),
        // onReorderStart: _reorderStartCallBack,
        // onReorderEnd: _reorderingEndCallBack,
        onReorder: _onReorderCallback,
        children: widgetList);
  }

// Call back functions
  void _reorderStartCallBack(int index) {
    ScaffoldMessenger.of(context).showSnackBar(ReORderingStatusSnackBar(
      content: 'Reordering!!',
    ));
  }

  void _reorderingEndCallBack(int index) {
    ScaffoldMessenger.of(context).showSnackBar(ReORderingStatusSnackBar(
      content: 'Reordered!',
    ));
  }

  void _onReorderCallback(int oldIndex, int newIndex) {
    setState(() {
      int updatedIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;
      widgetList.insert(updatedIndex, widgetList.removeAt(oldIndex));
    });
  }
}

// List representing text

class ListRepresentingText extends StatelessWidget {
  const ListRepresentingText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      text,
      style: const TextStyle(fontSize: 28),
    ));
  }
}

// Defining SnackBar
class ReORderingStatusSnackBar extends SnackBar {
  ReORderingStatusSnackBar({super.key, required String content})
      : super(
          content: Center(
              child: Text(
            content,
            style: const TextStyle(fontSize: 28),
          )),
          backgroundColor: Colors.blueGrey,
          behavior: SnackBarBehavior.floating,
        );
}
