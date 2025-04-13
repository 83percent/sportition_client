import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';
import 'package:sportition_client/models/records/main_record_dto.dart';
import 'package:sportition_client/services/user/user_service.dart';

class MainRecordsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final Logger _logger = Logger('RecordService');

  // Singleton
  static final MainRecordsService _recordService =
      MainRecordsService._internal();
  MainRecordsService._internal();
  factory MainRecordsService() {
    return _recordService;
  }

  List<MainRecordDTO>? _cachedRecords;

  Future<List<MainRecordDTO>> getMainRecordList() async {
    if (_cachedRecords != null) {
      return _cachedRecords!;
    }

    List<MainRecordDTO> resultList = [];

    try {
      String uid = await UserService().getUserUID();
      DateTime now = DateTime.now();
      DateTime oneYearAgo = DateTime(now.year - 1, now.month + 1, 1);

      for (DateTime date = oneYearAgo;
          date.isBefore(DateTime(now.year, now.month + 1, 1));
          date = DateTime(date.year, date.month + 1, 1)) {
        String collectionId =
            '${date.year}-${date.month.toString().padLeft(2, '0')}';
        DocumentSnapshot mainRecordSnapshot = await _firestore
            .collection('users')
            .doc(uid)
            .collection('mainRecords')
            .doc(collectionId)
            .get();

        if (mainRecordSnapshot.exists) {
          Map<String, dynamic> data =
              mainRecordSnapshot.data() as Map<String, dynamic>;
          List<MapEntry<String, dynamic>> sortedEntries = data.entries.toList()
            ..sort((a, b) => a.key.compareTo(b.key));

          for (var entry in sortedEntries) {
            String day = entry.key;
            Map<String, dynamic> exercises = entry.value;
            exercises.forEach((exerciseType, weight) {
              resultList.add(MainRecordDTO(
                date:
                    '${date.month.toString().padLeft(2, '0')}-${day.toString()}',
                exerciseType: exerciseType.toString(),
                weight: weight.toString(),
              ));
            });
          }
        }
      }
    } catch (e) {
      _logger.severe('Error: $e');
    }

    _cachedRecords = resultList;
    return resultList;
  }

  Future<List<MainRecordDTO>> getMainRecordListByExerciseType(
      String exerciseType) async {
    List<MainRecordDTO> resultList = [];

    try {
      List<MainRecordDTO> records = await getMainRecordList();
      resultList = records
          .where((element) => element.exerciseType == exerciseType)
          .toList()
        ..sort((a, b) => a.date.compareTo(b.date));
    } catch (e) {
      _logger.severe('Error: $e');
    }

    return resultList;
  }
}
