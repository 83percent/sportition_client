import 'package:flutter/material.dart';
import 'package:sportition_client/page/home/records/chart/record_chart_component.dart';

class RecordChartPage extends StatefulWidget {
  const RecordChartPage({Key? key}) : super(key: key);

  @override
  _RecordChartPageState createState() => _RecordChartPageState();
}

class _RecordChartPageState extends State<RecordChartPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            // RecordChartComponent(recordName: '종합', exerciseType: 'all'),
            RecordChartComponent(recordName: '데드리프트', exerciseType: 'deadlift'),
            RecordChartComponent(
                recordName: '벤츠프레스', exerciseType: 'benchpress'),
            RecordChartComponent(recordName: '스쿼트', exerciseType: 'squat'),
          ],
        ),
      ),
    );
  }
}
