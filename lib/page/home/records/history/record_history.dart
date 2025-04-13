import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportition_client/page/home/records/history/record_calendar_component.dart';
import 'package:sportition_client/page/home/records/history/record_history_list.dart';

class RecordHistory extends StatefulWidget {
  const RecordHistory({Key? key}) : super(key: key);

  @override
  _RecordHistoryState createState() => _RecordHistoryState();
}

class _RecordHistoryState extends State<RecordHistory> {
  DateTime recordDate = DateTime.now();
  String activeDate = '';
  final DateFormat formatter = DateFormat('yyyy년 MM월');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RecordCalendarComponent(
          recordDate: recordDate,
          formatter: formatter,
          onMonthChanged: (date) {
            setState(() {
              recordDate = date;
            });
          },
          onDateChanged: (date) {
            setState(() {
              activeDate = '${recordDate.year}-${recordDate.month}-$date';
            });
          },
        ),
        RecordHistoryList(),
      ],
    );
  }
}
