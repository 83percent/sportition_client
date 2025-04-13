import 'package:flutter/material.dart';
import 'package:sportition_client/services/user/user_service.dart';

class EditProfileDescriptionPage extends StatefulWidget {
  const EditProfileDescriptionPage({super.key});

  @override
  _EditProfileDescriptionPageState createState() =>
      _EditProfileDescriptionPageState();
}

class _EditProfileDescriptionPageState
    extends State<EditProfileDescriptionPage> {
  late String? description;
  late Future<void> _initializeDescriptionFuture;

  @override
  void initState() {
    super.initState();
    _initializeDescriptionFuture = _initializeDescription();
  }

  Future<void> _initializeDescription() async {
    final userDTO = await UserService().getUserDTO();
    setState(() {
      description = userDTO.description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeDescriptionFuture,
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
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        '소개 수정',
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
                          // 시각적인 로딩 이미지가 추가되면 좋을 것 같음
                          if (description != null) {
                            await UserService()
                                .updateUserDescription(description!);
                          }

                          Navigator.pop(context);
                        } catch (e) {
                          // 에러 메시지 출력
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
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
                    const SizedBox(height: 20),
                    TextField(
                      maxLines: null,
                      maxLength: 200,
                      decoration: InputDecoration(
                        hintText: '소개를 입력해주세요',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Notosans',
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
