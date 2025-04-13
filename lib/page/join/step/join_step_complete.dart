/*
회원 가입 완료

 */

import 'package:flutter/material.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class JoinStepComplete extends StatefulWidget {
  const JoinStepComplete({Key? key}) : super(key: key);

  @override
  _JoinStepCompleteState createState() => _JoinStepCompleteState();
}

class _JoinStepCompleteState extends State<JoinStepComplete> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /* Join Box */
        const Center(
          child: Text(
            'SPORTITION',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.mainRedColor,
            ),
          ),
        ),
        const Center(
          child: Text(
            '가입이 완료되었습니다.',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Center(
          child: Icon(
            Icons.check_circle,
            color: AppColors.mainRedColor,
            size: 70,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextButton(
          onPressed: () {
            Navigator.restorablePushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          },
          child: const Text(
            '로그인',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.mainRedColor,
            ),
          ),
        ),
      ],
    );
  }
}
