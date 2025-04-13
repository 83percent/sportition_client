import 'package:flutter/material.dart';
import 'package:sportition_client/models/records/exercise_record_detail_dto.dart';
import 'package:sportition_client/models/records/exercise_record_dto.dart';

class RecordHistoryList extends StatefulWidget {
  const RecordHistoryList({Key? key}) : super(key: key);

  @override
  _RecordHistoryListState createState() => _RecordHistoryListState();
}

class _RecordHistoryListState extends State<RecordHistoryList> {
  List<ExerciseRecordDTO> exerciseRecordList = [
    ExerciseRecordDTO(
      exerciseName: '스쿼트',
      exerciseId: 'squat',
      exerciseRecordDetailList: [
        ExerciseRecordDetailDTO(weight: '70', count: '8'),
        ExerciseRecordDetailDTO(weight: '80', count: '8'),
        ExerciseRecordDetailDTO(weight: '100', count: '3'),
      ],
    ),
    ExerciseRecordDTO(
      exerciseName: '숄더프레스',
      exerciseId: 'shoulderpress',
      exerciseRecordDetailList: [
        ExerciseRecordDetailDTO(weight: '10', count: '10'),
        ExerciseRecordDetailDTO(weight: '15', count: '8'),
        ExerciseRecordDetailDTO(weight: '12', count: '7'),
      ],
    ),
    ExerciseRecordDTO(
      exerciseName: '벤치프레스',
      exerciseId: 'benchpress',
      exerciseRecordDetailList: [
        ExerciseRecordDetailDTO(weight: '50', count: '8'),
        ExerciseRecordDetailDTO(weight: '60', count: '6'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 30),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: exerciseRecordList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      exerciseRecordList[index].exerciseName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NotoSansKR',
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: exerciseRecordList[index]
                          .exerciseRecordDetailList
                          .map((e) => Row(
                                children: [
                                  Expanded(
                                    child: Text('무게: ${e.weight}kg'),
                                  ),
                                  Expanded(
                                    child: Text('횟수: ${e.count}회'),
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
