import 'package:flutter/material.dart';
import 'package:sportition_client/page/settings/setting_menu_element.dart';
import 'package:sportition_client/services/login/login_service.dart';

/* 설정 페이지 */
class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '설정',
          style: TextStyle(
            fontSize: 19,
            fontFamily: 'Notosans',
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              SettingMenuElement(
                title: '프로필 수정',
                onPressed: () {
                  Navigator.pushNamed(context, '/setting/edit/profile');
                },
              ),
              SettingMenuElement(
                title: '나의 운동 센터',
                onPressed: () {
                  Navigator.pushNamed(context, '/center');
                },
              ),
              SettingMenuElement(
                title: '로그아웃',
                onPressed: () {
                  LoginService().logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
