import 'package:flutter/material.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class SettingMenuElement extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const SettingMenuElement({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // 패딩 제거
        minimumSize: Size.zero, // 최소 크기 제거
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역 축소
      ),
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.borderGray100Color,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
