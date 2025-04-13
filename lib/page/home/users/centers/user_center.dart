import 'package:flutter/material.dart';
import 'package:sportition_client/models/centers/center_dto.dart';
import 'package:sportition_client/page/home/users/centers/user_non_exist_centerUID.dart';
import 'package:sportition_client/services/center/center_service.dart';

class UserCenter extends StatefulWidget {
  const UserCenter({
    Key? key,
  }) : super(key: key);

  @override
  _UserCenterState createState() => _UserCenterState();
}

class _UserCenterState extends State<UserCenter> {
  CenterDTO? centerDTO;

  Future<CenterDTO?> fetchCenterDTO() async {
    // CenterDTO를 가져오는 로직을 여기에 추가하세요.
    centerDTO = await CenterService().getCenterInfo();
    return centerDTO; // 예시로 기존 centerDTO를 반환
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '센터',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'NotoSansKR',
            ),
          ),
          FutureBuilder<CenterDTO?>(
            future: fetchCenterDTO(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('오류가 발생했습니다.');
              } else if (snapshot.hasData && snapshot.data != null) {
                return ExistCenter(
                  centerName: snapshot.data!.centerName,
                );
              } else {
                return const UserNonExistCenterUID();
              }
            },
          ),
        ],
      ),
    );
  }
}

class ExistCenter extends StatelessWidget {
  final String centerName;

  const ExistCenter({Key? key, required this.centerName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        centerName,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'NotoSansKR',
        ),
      ),
    );
  }
}
