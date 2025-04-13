import 'package:flutter/material.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class UserProfileEditButton extends StatelessWidget {
  const UserProfileEditButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.borderGray010Color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            '프로필 수정',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Notosans',
            ),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/setting/edit/profile');
        },
      ),
    );
  }
}
