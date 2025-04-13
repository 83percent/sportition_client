/*
 * 회원 가입 3단계
 * - 사용자 이름 선택
 * 
 */

import 'package:flutter/material.dart';
import 'package:sportition_client/exception/join_exception.dart';
import 'package:sportition_client/models/clients/join_dto.dart';
import 'package:sportition_client/services/join/join_service.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class JoinStep3 extends StatefulWidget {
  final JoinDTO joinDTO;
  final Future<void> Function() join; // join 메서드 추가

  const JoinStep3({
    Key? key,
    required this.joinDTO,
    required this.join, // join 메서드 추가
  }) : super(key: key);

  @override
  _JoinStep3State createState() => _JoinStep3State();
}

class _JoinStep3State extends State<JoinStep3> {
  final TextEditingController userNameController = TextEditingController();
  bool isProcessing = false;

  String errorMessage = "";
  late JoinService joinService;

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
      joinService.validateUserName(userNameController.text);

      // remove error message
      errorMessage = "";

      // set userName
      widget.joinDTO.setUserName = userNameController.text;

      // call join method
      await widget.join(); // join 메서드 호출
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
        alignment: Alignment.center,
        width: 370,
        child: Column(
          children: [
            const Center(
              child: Text(
                '사용자 이름 선택',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Center(
              child: Text(
                '나중에 언제든지 변경할 수 있습니다.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: TextField(
                controller: userNameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '사용자 이름',
                ),
                enabled: !isProcessing, // 처리 중일 때 입력 방지
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
