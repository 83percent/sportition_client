import 'package:flutter/material.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/setting');
            },
            icon: const Icon(
              Icons.settings_outlined,
              size: 30,
              color: AppColors.borderGray100Color,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
          )
        ],
      ),
    );
  }
}
