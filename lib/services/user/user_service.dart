import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportition_client/exception/login_exception.dart';
import 'package:sportition_client/exception/not_found_exception.dart';
import 'package:sportition_client/models/users/user_dto.dart';

class UserService {
  static final Logger _logger = Logger('LoginService');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _userUID;
  UserDTO? _userDTO;

  // Singleton
  static final UserService _userService = UserService._internal();
  UserService._internal();
  factory UserService() {
    return _userService;
  }

  // get User UID
  Future<String> getUserUID() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userUID = prefs.getString('userUID') ?? '';

      // UID 후 보유하고있는 아이디랑 다르면 Snapshot을 다시 받아옴
      if (_userUID == null || _userUID != userUID) {
        _userUID = userUID;
        _userDTO = null;
      }

      return _userUID ?? '';
    } catch (e) {
      _logger.log(Level.ALL, 'getUserUID error: $e');
      throw LoginException('오류가 발생하였습니다.');
    }
  }

  /// Firestore에서 User 정보를 가져옴
  /// @param uid User UID
  /// @throws NotFoundException Firestore에서 User 정보를 찾을 수 없을 경우
  /// @return User 정보
  Future<DocumentSnapshot> _getUserSnapShot(uid) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(uid).get();
      return snapshot;
    } catch (e) {
      throw NotFoundException('사용자 정보가 없습니다.');
    }
  }

  /// Firestore에서 User DocumentSnapshot을 UserDTO로 변환
  /// @param userSnapshot User DocumentSnapshot
  /// @return UserDTO
  UserDTO _convertUserDTO(DocumentSnapshot userSnapshot) {
    Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;

    return UserDTO(
      uid: userSnapshot.id,
      userName: data['userName'] ?? '',
      gender: data['gender'] ?? '',
      description: data['description'] ?? '',
      centerUID: data['centerUID'] ?? '',
    );
  }

  /// UserDTO를 가져옴
  /// @return UserDTO
  /// @throws NotFoundException Firestore에서 User 정보를 찾을 수 없을 경우
  Future<UserDTO> getUserDTO() async {
    // _userUID가 없을 경우, getUserUID()를 통해 가져옴
    String userUID;
    if (_userUID == null) {
      userUID = await getUserUID();
    } else {
      userUID = _userUID!;
    }

    // Non Refresh
    if (_userDTO != null && _userDTO?.uid != null && userUID == _userDTO?.uid) {
      return _userDTO!;
    }

    DocumentSnapshot userSnapshot = await _getUserSnapShot(userUID);
    _userDTO = _convertUserDTO(userSnapshot);
    return _userDTO!;
  }

  /// UserDTO를 최신화된 데이터로 갱신
  /// @throws NotFoundException Firestore에서 User 정보를 찾을 수 없을 경우
  /// @throws LoginException User UID를 찾을 수 없을 경우
  /// @throws Exception
  Future<void> refreshUserDTO() async {
    String userUID = await getUserUID();
    DocumentSnapshot userSnapshot = await _getUserSnapShot(userUID);
    _userDTO = _convertUserDTO(userSnapshot);
  }

  Future<void> updateUserName(String userName) async {
    try {
      String userUID = await getUserUID();
      await _firestore.collection('users').doc(userUID).update({
        'userName': userName,
      });
    } catch (e) {
      _logger.log(Level.ALL, 'updateUserName error: $e');
      throw Exception('사용자 이름을 수정할 수 없습니다.');
    }
  }

  Future<void> updateUserGender(String gender) async {
    try {
      String userUID = await getUserUID();
      await _firestore.collection('users').doc(userUID).update({
        'gender': gender,
      });
    } catch (e) {
      _logger.log(Level.ALL, 'updateUserGender error: $e');
      throw Exception('성별을 수정할 수 없습니다.');
    }
  }

  Future<void> updateUserDescription(String description) async {
    try {
      String userUID = await getUserUID();
      await _firestore.collection('users').doc(userUID).update({
        'description': description,
      });
    } catch (e) {
      _logger.log(Level.ALL, 'updateUserDescription error: $e');
      throw Exception('소개를 수정할 수 없습니다.');
    }
  }
}
