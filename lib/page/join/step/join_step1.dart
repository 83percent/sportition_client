/*
* 회원 가입 1단계
* - 복구 이메일 입력
*/

import 'package:flutter/material.dart';
import 'package:sportition_client/exception/join_exception.dart';
import 'package:sportition_client/models/clients/join_dto.dart';
import 'package:sportition_client/services/join/join_service.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class JoinStep1 extends StatefulWidget {
  final ValueChanged<int> onPageIndexChanged;
  final JoinDTO joinDTO;

  const JoinStep1({
    Key? key,
    required this.onPageIndexChanged,
    required this.joinDTO,
  }) : super(key: key);

  @override
  _JoinStep1State createState() => _JoinStep1State();
}

class _JoinStep1State extends State<JoinStep1> {
  TextEditingController emailController = TextEditingController();
  late JoinService joinService;
  bool isProcessing = false; // 추가된 변수

  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    joinService = JoinService();
  }

  // Event : 다음 버튼 클릭
  void _handleNextButtonPressed() async {
    setState(() {
      isProcessing = true; // 버튼 클릭 시 처리 중 상태로 변경
    });
    try {
      // validate
      await joinService.validateEmail(emailController.text);

      // remove error message
      errorMessage = "";

      // set email
      widget.joinDTO.setEmail = emailController.text;

      // move next page
      widget.onPageIndexChanged(2);
    } on JoinException catch (e) {
      setState(() {
        errorMessage = e.getMessage();
      });
    } on Exception {
      setState(() {
        errorMessage = '잠시 후 다시 시도해주세요.';
      });
    } finally {
      setState(() {
        isProcessing = false; // 처리 완료 후 상태 변경
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
            /* Join Box */
            const Center(
              child: Text(
                '이메일 입력',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Center(
              child: Text(
                '로그인에 사용될 이메일을 입력하세요.',
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
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '이메일',
              ),
              enabled: !isProcessing, // 처리 중일 때 입력 방지
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
              onPressed: isProcessing
                  ? null
                  : _handleNextButtonPressed, // 처리 중일 때 중복 클릭 방지
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
