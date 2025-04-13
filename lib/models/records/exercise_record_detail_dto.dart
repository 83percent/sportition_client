class ExerciseRecordDetailDTO {
  final String weight; // 무게
  final String count; // 횟수
  String? regDttm; // 등록일시

  ExerciseRecordDetailDTO({
    required this.weight,
    required this.count,
    this.regDttm,
  });
}
