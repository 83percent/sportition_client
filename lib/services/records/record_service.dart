import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';
import 'package:sportition_client/exception/validate_exception.dart';
import 'package:sportition_client/models/records/exercise_record_dto.dart';
import 'package:sportition_client/services/user/user_service.dart';

class RecordService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final Logger _logger = Logger('RecordService');

  // Singleton
  static final RecordService _recordService = RecordService._internal();
  RecordService._internal();
  factory RecordService() {
    return _recordService;
  }

  Future<Map<String, List<ExerciseRecordDTO>>> getExerciseRecordList(
      String year, String month) async {
    String collectionParameter = '';
    Map<String, List<ExerciseRecordDTO>> resultMap = {};

    try {
      /* Validate */
      /*      Year    */
      if (year.isEmpty) {
        throw ValidateException('Year is empty');
      }

      if (year.length != 4) {
        throw ValidateException('Invalid year format');
      }

      /*      Month    */
      if (month.isEmpty) {
        throw ValidateException('Month is empty');
      }

      if (month.length < 1 || month.length > 2) {
        throw ValidateException('Invalid month format');
      }

      /* Format Check */
      if (month.length == 1) {
        month = '0$month';
      }

      // Firestore 에서 운동 기록 조회
      collectionParameter = '$year-$month';

      String uid = await UserService().getUserUID();
      DocumentSnapshot exerciseRecordSnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('exerciseRecords')
          .doc(collectionParameter)
          .get();

      if (exerciseRecordSnapshot.exists) {
        Map<String, dynamic> data =
            exerciseRecordSnapshot.data() as Map<String, List<dynamic>>;

        data.forEach((key, value) {
          resultMap[key] = ExerciseRecordDTO.convertFromSnapshot(value);
        });
      }
    } catch (e) {
      _logger.log(Level.ALL, 'getExerciseRecordList error: $e');
      throw Exception('오류가 발생하였습니다.');
    }
    return resultMap;
  }
}
