import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportition_client/models/centers/center_dto.dart';
import 'package:sportition_client/models/users/user_dto.dart';
import 'package:sportition_client/services/user/user_service.dart';

class CenterService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Singleton
  static final CenterService _centerService = CenterService._internal();
  CenterService._internal();
  factory CenterService() {
    return _centerService;
  }

  Future<CenterDTO?> getCenterInfo() async {
    // UserDTO를 가져오기 위해 UserService를 사용
    UserDTO userDTO = await UserService().getUserDTO();

    // userDTO에서 centerUID를 가져옴
    String? centerUID = userDTO.centerUID;
    if (centerUID == null || centerUID.isEmpty) {
      return null; // Center UID가 없으면 null 반환
    }

    // Firestore에서 centerUID에 해당하는 DocumentSnapshot을 가져옴
    DocumentSnapshot centerSnapshot =
        await _firestore.collection('centers').doc(centerUID).get();

    if (centerSnapshot.exists) {
      Map<String, dynamic> data = centerSnapshot.data() as Map<String, dynamic>;
      return CenterDTO(
        centerName: data['name'] ?? '',
        centerUID: centerUID,
      );
    } else {
      throw Exception('Center not found');
    }
  }

  // CenterUID 유효성 체크
  Future<bool> isValidCenterUID(String centerUID) async {
    DocumentSnapshot centerSnapshot =
        await _firestore.collection('centers').doc(centerUID).get();

    if (centerSnapshot.exists) {
      return true; // 유효한 Center UID
    } else {
      return false; // 유효하지 않은 Center UID
    }
  }

  Future<void> saveCenterUID(String centerUID) async {
    // UserService를 사용하여 현재 사용자 UID를 가져옴
    String userUID = await UserService().getUserUID();

    // Firestore에서 해당 사용자 문서를 업데이트
    DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(userUID).get();

    Map<String, dynamic> originData =
        userSnapshot.data() as Map<String, dynamic>;

    if (originData['centerUID'] != null) {
      // 기존 centerUID가 있는 경우
      // 기존 /centers/{centerUID}/clients/{userUID} 문서삭제
      try {
        await _firestore
            .collection('centers')
            .doc(originData['centerUID'])
            .collection('clients')
            .doc(userUID)
            .delete();
      } catch (e) {}
    }

    await _firestore.collection('users').doc(userUID).update({
      'centerUID': centerUID,
    });

    await _firestore
        .collection('centers')
        .doc(centerUID)
        .collection('clients')
        .doc(userUID)
        .set(
      {
        'clientUID': userUID,
        'clientName': originData['name'],
        'gender': originData['gender'] ?? 'unset',
        'regDttm': FieldValue.serverTimestamp(),
      },
    );
  }
}
