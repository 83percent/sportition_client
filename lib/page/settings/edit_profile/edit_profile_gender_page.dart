import 'package:flutter/material.dart';
import 'package:sportition_client/services/user/user_service.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class EditProfileGenderPage extends StatefulWidget {
  const EditProfileGenderPage({Key? key}) : super(key: key);

  @override
  _EditProfileGenderPageState createState() => _EditProfileGenderPageState();
}

class _EditProfileGenderPageState extends State<EditProfileGenderPage> {
  late String? gender;
  late Future<void> _initializeGenderFuture;

  @override
  void initState() {
    super.initState();
    _initializeGenderFuture = _initializeGender();
  }

  Future<void> _initializeGender() async {
    // 성별 정보를 가져오는 로직 추가
    final userDTO = await UserService().getUserDTO();
    setState(() {
      gender = userDTO.gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeGenderFuture,
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
                      '성별 수정',
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
                        if (gender != null) {
                          await UserService().updateUserGender(gender!);
                        }

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
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: IconButton(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            icon: Icon(
                              Icons.male,
                              size: gender == 'male' ? 32 : 28,
                              color: gender == 'male'
                                  ? Colors.blue
                                  : AppColors.borderGray100Color,
                            ),
                            onPressed: () {
                              if (gender != 'male') {
                                setState(() {
                                  gender = 'male';
                                });
                              }
                            },
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 20,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColors.borderGray100Color,
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            icon: Icon(
                              Icons.female,
                              size: gender == 'female' ? 32 : 28,
                              color: gender == 'female'
                                  ? AppColors.mainRedColor
                                  : AppColors.borderGray100Color,
                            ),
                            onPressed: () {
                              if (gender != 'female') {
                                setState(() {
                                  gender = 'female';
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
