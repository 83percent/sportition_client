import 'package:flutter/material.dart';
import 'package:sportition_client/exception/login_exception.dart';
import 'package:sportition_client/models/clients/login_dto.dart';
import 'package:sportition_client/services/login/login_service.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class LoginBox extends StatefulWidget {
  final double loginBoxOffset;
  final ValueChanged<String> setErrorMessage;

  const LoginBox({
    Key? key,
    required this.loginBoxOffset,
    required this.setErrorMessage,
  }) : super(key: key);

  @override
  _LoginBoxState createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late LoginService loginService;

  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    loginService = LoginService();
  }

  Future<void> _handleLoginButtonPressed() async {
    setState(() {
      isProcessing = true;
    });

    LoginDTO loginDTO = LoginDTO(
      email: emailController.text,
      password: passwordController.text,
    );

    try {
      // Login
      bool isPassed = await loginService.login(loginDTO);

      // Move to home page
      if (isPassed) Navigator.pushReplacementNamed(context, '/home');
    } on LoginException catch (e) {
      widget.setErrorMessage(e.getMessage());
    } on Exception {
      widget.setErrorMessage('로그인에 실패하였습니다. 잠시 후 다시 시도해주세요.');
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 200,
      ),
      transform: Matrix4.translationValues(0, widget.loginBoxOffset, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, -1), // 위로 그림자가 생기게 설정
          ),
        ],
        border: Border.all(
          color: AppColors.borderGray100Color,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '이메일',
            ),
            enabled: !isProcessing,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: passwordController,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '비밀번호',
            ),
            enabled: !isProcessing,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: isProcessing ? null : _handleLoginButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainRedColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // 모서리를 둥글게 설정
              ),
              minimumSize: const Size.fromHeight(50), // 좌우가 꽉 차게 설정
            ),
            child: const Text(
              '로그인',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/join');
            },
            child: const Text(
              '회원가입',
              style: TextStyle(
                color: AppColors.mainRedColor,
                fontSize: 14,
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
