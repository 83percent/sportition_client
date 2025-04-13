import 'package:flutter/material.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class UserNonExistCenterUID extends StatefulWidget {
  const UserNonExistCenterUID({Key? key}) : super(key: key);

  @override
  _UserNonExistCenterUIDState createState() => _UserNonExistCenterUIDState();
}

class _UserNonExistCenterUIDState extends State<UserNonExistCenterUID> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
      ),
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/center',
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderGray100Color,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 16,
              color: Colors.black,
            ),
            Text(
              '나의 운동 센터 설정하기',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'NotoSansKR',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
