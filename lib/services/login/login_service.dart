import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportition_client/exception/login_exception.dart';
import 'package:sportition_client/models/clients/login_dto.dart';

class LoginService {
  static final Logger _logger = Logger('LoginService');

  // Singleton
  static final LoginService _loginService = LoginService._internal();
  LoginService._internal();
  factory LoginService() {
    return _loginService;
  }

  Future<bool> isLogin() async {
    _logger.log(Level.ALL,
        '====================== LOGIN SERVICE ======================');

    // SharedPreferences 에서 저장되어q있는 clientUID를 가져온다.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userUID = prefs.getString('userUID');

    _logger.log(Level.ALL, 'userUID: $userUID');

    // Firebase Authentication의 현재 사용자를 가져온다.
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (userUID != null && currentUser != null && currentUser.uid == userUID) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> login(LoginDTO loginDTO) async {
    // Validate
    if (loginDTO.email.isEmpty) {
      throw LoginException('이메일을 입력해주세요.');
    }

    // email validation
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(loginDTO.email)) {
      throw LoginException('이메일 형식이 올바르지 않습니다.');
    }

    if (loginDTO.password.isEmpty) {
      throw LoginException('비밀번호를 입력해주세요.');
    }

    /* 입력 글자 수 확인 */
    if (loginDTO.password.length < 8 || loginDTO.password.length > 20) {
      throw LoginException("8자 이상 20자 이하로 입력해주세요.");
    }

    /* 문자 조합 확인 */
    /* 영어, 숫자, 특수문자 !@#%^&* 만 가능 */
    if (!RegExp(r'^[a-zA-Z0-9!@#%^&*]*$').hasMatch(loginDTO.password)) {
      throw LoginException("영어 대소문자, 숫자, !@#%^&* 만 입력 가능합니다.");
    }

    try {
      // 로그인 시도
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginDTO.email,
        password: loginDTO.password,
      );

      // 로그인 성공 시 SharedPreferences에 userUID 저장
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userUID', userCredential.user!.uid);

      return true;
    } catch (e) {
      _logger.log(Level.ALL, 'Login Fail: $e');
      throw LoginException('이메일 또는 비밀번호가 올바르지 않습니다.');
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userUID');
  }
}
