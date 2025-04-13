import 'package:flutter/material.dart';
import 'package:sportition_client/services/user/user_service.dart';

class EditProfileNamePage extends StatefulWidget {
  const EditProfileNamePage({Key? key}) : super(key: key);

  @override
  _EditProfileNamePageState createState() => _EditProfileNamePageState();
}

class _EditProfileNamePageState extends State<EditProfileNamePage> {
  String? userName;
  late TextEditingController _controller;
  late Future<void> _initializeUserNameFuture;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _initializeUserNameFuture = _initializeUserName();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeUserName() async {
    final userDTO = await UserService().getUserDTO();
    setState(() {
      userName = userDTO.userName;
      _controller.text = userName ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeUserNameFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: Text('오류가 발생했습니다.')),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  const Expanded(
                    child: Text(
                      '사용자 이름 수정',
                      style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'Notosans',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      // 저장 로직 추가
                      try {
                        await UserService().updateUserName(_controller.text);
                        await UserService().refreshUserDTO();

                        // 시각적인 로딩 이미지가 추가되면 좋을 것 같음

                        Navigator.pop(context);
                      } catch (e) {
                        // 에러 메시지 출력
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('오류가 발생했습니다.'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 30,
                    ),
                    padding: const EdgeInsets.all(10),
                  ),
                ],
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '사용자 이름',
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
