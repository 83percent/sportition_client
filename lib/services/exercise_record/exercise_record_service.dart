import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportition_client/models/records/exercise_record_dto.dart';

class ExerciseRecordService {
  // Singleton
  static final ExerciseRecordService _instance =
      ExerciseRecordService._internal();
  ExerciseRecordService._internal();
  factory ExerciseRecordService() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
}
