/*
* 회원 가입 2단계
* - 비밀번호 입력
*/

import 'package:flutter/material.dart';
import 'package:sportition_client/exception/join_exception.dart';
import 'package:sportition_client/models/clients/join_dto.dart';
import 'package:sportition_client/services/join/join_service.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class JoinStep2 extends StatefulWidget {
  final ValueChanged<int> onPageIndexChanged;
  final JoinDTO joinDTO;

  const JoinStep2({
    Key? key,
    required this.onPageIndexChanged,
    required this.joinDTO,
  }) : super(key: key);

  @override
  _JoinStep2State createState() => _JoinStep2State();
}

class _JoinStep2State extends State<JoinStep2> {
  final TextEditingController passwordController = TextEditingController();
  late JoinService joinService;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    joinService = JoinService();
  }

  // 다음버튼 클릭 시
  void _handleNextButtonPressed() async {
    try {
      // validate
      joinService.validatePassword(passwordController.text);

      // set password
      widget.joinDTO.password = passwordController.text;

      // move next page
      widget.onPageIndexChanged(3);
    } on JoinException catch (e) {
      setState(() {
        errorMessage = e.getMessage();
      });
    } on Exception {
      setState(() {
        errorMessage = '잠시 후 다시 시도해주세요.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 370,
        alignment: Alignment.center,
        child: Column(
          children: [
            const Center(
              child: Text(
                '비밀번호 만들기',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Center(
              child: Text(
                '보안을 위해 비밀번호는 8자 이상 입력하세요.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '비밀번호',
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                errorMessage, // Error Message
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _handleNextButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainRedColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                '다음',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
