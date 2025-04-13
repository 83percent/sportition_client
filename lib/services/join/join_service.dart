import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sportition_client/exception/join_exception.dart';
import 'package:sportition_client/models/clients/join_dto.dart';

class JoinService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Singleton
  static final JoinService _instance = JoinService._internal();
  JoinService._internal();
  factory JoinService() {
    return _instance;
  }

  /*  이메일 유효성 검사 */
  Future<void> validateEmail(String email) async {
    /* 입력 여부 확인 */
    if (email.isEmpty) {
      throw JoinException("이메일을 입력해주세요.");
    }

    /* 이메일 형식 확인 */
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email)) {
      throw JoinException("이메일 형식이 올바르지 않습니다.");
    }

    /* Firebase에 이미 회원가입한 이메일인지 확인 */
    QuerySnapshot userQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (userQuery.docs.isNotEmpty) {
      throw JoinException("이미 가입된 이메일입니다.");
    }
  }

  /* 사용자 이름 유효성 검사 */
  void validateUserName(String userName) {
    /* 입력 여부 확인 */
    if (userName.isEmpty) {
      throw JoinException("사용자 이름을 입력해주세요.");
    }

    /* 입력 글자 수 확인 */
    if (userName.length < 5 || userName.length > 20) {
      throw JoinException("5자 이상 20자 이하로 입력해주세요.");
    }

    /* 문자 조합 확인 */
    /* 영어, 숫자, 특수문지 _, . 만 가능 */
    if (!RegExp(r'^[a-zA-Z0-9_.]*$').hasMatch(userName)) {
      throw JoinException("영어 대소문자, 숫자, _, . 만 입력 가능합니다.");
    }
  }

  /* 비밀번호 유효성 확인 */
  void validatePassword(String password) {
    /* 입력 여부 확인 */
    if (password.isEmpty) {
      throw JoinException("비밀번호를 입력해주세요.");
    }

    /* 입력 글자 수 확인 */
    if (password.length < 8 || password.length > 20) {
      throw JoinException("8자 이상 20자 이하로 입력해주세요.");
    }

    /* 문자 조합 확인 */
    /* 영어, 숫자, 특수문자 !@#%^&* 만 가능 */
    if (!RegExp(r'^[a-zA-Z0-9!@#%^&*]*$').hasMatch(password)) {
      throw JoinException("영어 대소문자, 숫자, !@#%^&* 만 입력 가능합니다.");
    }
  }

  /**
   * 회원가입
   * @param joinDTO
   * @throws JoinException
   */
  Future<void> join(JoinDTO joinDTO) async {
    // Null Check
    if (joinDTO.email.isEmpty ||
        joinDTO.password.isEmpty ||
        joinDTO.userName.isEmpty) {
      throw JoinException("모든 항목을 입력해주세요.");
    }

    // Create User Account
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: joinDTO.email, password: joinDTO.password);

    // Firebase Auth uid
    String uid = userCredential.user!.uid;

    // 저장을 시도하고, 실패할 경우 userCredential.user.delete()를 호출하여 회원가입을 취소한다.
    try {
      await _firestore.collection('users').doc(uid).set({
        'email': joinDTO.email,
        'userName': joinDTO.userName,
        'gender': joinDTO.gender, // 값이 없는 경우 'unset'으로 저장
        'created': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      userCredential.user!.delete();
      throw JoinException("회원가입에 실패했습니다. 잠시 후 다시 시도해주세요.");
    }
  }
}
