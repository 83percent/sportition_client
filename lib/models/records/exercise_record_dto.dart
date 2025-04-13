import 'dart:ffi';

import 'package:sportition_client/models/records/exercise_record_detail_dto.dart';

class ExerciseRecordDTO {
  final String exerciseName; // 운동명
  final String exerciseId; // 운동ID
  final List<ExerciseRecordDetailDTO> exerciseRecordDetailList;

  ExerciseRecordDTO({
    required this.exerciseName,
    required this.exerciseId,
    required this.exerciseRecordDetailList,
  });

  static List<ExerciseRecordDTO> convertFromSnapshot(List<dynamic> snapshot) {
    List<ExerciseRecordDTO> exerciseRecordList = [];

    snapshot.forEach((element) {
      List<ExerciseRecordDetailDTO> exerciseRecordDetailList = [];

      List<dynamic> detailList = element['records'];

      detailList.forEach((detail) {
        exerciseRecordDetailList.add(ExerciseRecordDetailDTO(
          weight: detail['weight'],
          count: detail['count'],
        ));
      });

      exerciseRecordList.add(ExerciseRecordDTO(
        exerciseName: element['exerciseName'],
        exerciseId: element['exerciseId'],
        exerciseRecordDetailList: exerciseRecordDetailList,
      ));
    });

    return exerciseRecordList;
  }
}
