import 'package:flutter/material.dart';
import 'package:my_calculator/colors.dart';
import 'package:my_calculator/widget/appbar.dart';

class History extends StatefulWidget {
  //historyItem? history;
  final List myList;
  const History(
    this.myList, {
    Key? key,
    //required this.history,
  }) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        'History',
        Icons.auto_delete_outlined,
        () {
          widget.myList.clear();
          setState(() {});
          // Navigator.pop(context);
        },
      ),
      body: widget.myList.isEmpty // result.isEmpty
          ? Center(
              child: Text(
                'Empty!',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(fontSize: 20.0),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(10.0),
              itemCount: widget.myList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10),
              itemBuilder: (BuildContext context, int i) {
                return Card(
                  shadowColor: kMainButtonsColor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        widget.myList.removeAt(i);
                        setState(() {});
                      },
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    tileColor: kMainButtonsColor.withOpacity(0.1),
                    title: Text(widget.myList[i].result!),
                    subtitle: Text(widget.myList[i].expression!),
                  ),
                );
              },
            ),
    );
  }
}
