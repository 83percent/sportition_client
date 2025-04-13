import 'package:flutter/material.dart';
import 'package:sportition_client/services/center/center_service.dart';

class EditCenterPage extends StatefulWidget {
  @override
  _EditCenterPageState createState() => _EditCenterPageState();
}

class _EditCenterPageState extends State<EditCenterPage> {
  String? centerUID;

  Future<void> saveCenter() async {
    // 입력한 centerUID가 실제로 존재하는 center인지 확인
    bool existCenter = false;
    existCenter = await CenterService().isValidCenterUID(centerUID!);
    if (!existCenter) {
      // 존재하지 않는 센터 UID일 경우, '존재하지 않는 센터입니다.' 메시지 띄우기
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('존재하지 않는 센터입니다.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // 존재하는 센터 UID일 경우, 센터 UID 저장
      try {
        await CenterService().saveCenterUID(centerUID!);
        // 저장 성공 메시지
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('센터 UID가 저장되었습니다.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        // 뒤로가기
        Navigator.pop(context);
      } catch (e) {
        // 에러 처리
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('센터 UID 저장에 실패했습니다.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '센터 설정',
          style: TextStyle(
            fontSize: 19,
            fontFamily: 'Notosans',
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              saveCenter();
            },
            icon: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.green,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  centerUID = value;
                });
              },
              decoration: const InputDecoration(
                labelText: '센터 UID 입력..',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
