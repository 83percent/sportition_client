import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sportition_client/services/records/main_records_service.dart';
import 'package:sportition_client/models/records/main_record_dto.dart';
import 'package:intl/intl.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class RecordChartComponent extends StatefulWidget {
  final String recordName;
  final String exerciseType;

  RecordChartComponent({
    Key? key,
    required this.recordName,
    required this.exerciseType,
  }) : super(key: key);

  @override
  _RecordChartComponentState createState() => _RecordChartComponentState();
}

class _RecordChartComponentState extends State<RecordChartComponent> {
  late Future<List<MainRecordDTO>> _recordListFuture;

  @override
  void initState() {
    super.initState();
    _recordListFuture = MainRecordsService()
        .getMainRecordListByExerciseType(widget.exerciseType);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.recordName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: FutureBuilder<List<MainRecordDTO>>(
              future: _recordListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  List<MainRecordDTO> records = snapshot.data!;
                  return LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: records.map((record) {
                            DateTime date =
                                DateFormat('MM-dd').parse(record.date);
                            return FlSpot(
                              date.millisecondsSinceEpoch.toDouble(),
                              double.parse(record.weight),
                            );
                          }).toList(),
                          isCurved: false,
                          colors: [AppColors.mainRedColor],
                          barWidth: 3,
                          belowBarData: BarAreaData(
                            show: true,
                            colors: [
                              AppColors.mainRedColor.withOpacity(0.3),
                            ],
                          ),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        topTitles: SideTitles(
                          showTitles: false,
                        ),
                        rightTitles: SideTitles(
                          showTitles: true,
                        ),
                        leftTitles: SideTitles(
                          showTitles: false,
                        ),
                        bottomTitles: SideTitles(
                          showTitles: true,
                          getTitles: (value) {
                            DateTime date = DateTime.fromMillisecondsSinceEpoch(
                                value.toInt());
                            return '${date.month}/${date.day}';
                          },
                        ),
                      ),
                      borderData: FlBorderData(show: true),
                      gridData: FlGridData(show: true, drawVerticalLine: true),
                    ),
                  );
                } else {
                  return const Center(child: Text('운동 데이터가 아직 없습니다.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
