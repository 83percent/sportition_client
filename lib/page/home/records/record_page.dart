import 'package:flutter/material.dart';
import 'package:sportition_client/page/home/records/chart/record_chart_page.dart';
import 'package:sportition_client/page/home/records/history/record_history.dart';
import 'package:sportition_client/page/home/records/record_header.dart';

/* 운동 기록 페이지 */
class RecordPage extends StatefulWidget {
  final String userUID;
  const RecordPage({Key? key, required this.userUID}) : super(key: key);

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  int _showIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 60,
        ),
        RecordHeader(
          showIndex: _showIndex,
          onIndexChanged: (index) {
            setState(() {
              _showIndex = index;
            });
          },
        ),
        Expanded(
          child: IndexedStack(
            index: _showIndex,
            children: [
              RecordChartPage(),
              RecordHistory(),
            ],
          ),
        ),
      ],
    );
  }
}
