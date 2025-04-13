import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseHistoryService {
  // Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Singleton
  static final ExerciseHistoryService _instance =
      ExerciseHistoryService._internal();
  ExerciseHistoryService._internal();
  factory ExerciseHistoryService() {
    return _instance;
  }
}
