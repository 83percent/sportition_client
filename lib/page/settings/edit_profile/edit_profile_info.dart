import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sportition_client/models/users/user_dto.dart';

class EditProfileInfo extends StatefulWidget {
  UserDTO? userDTO;

  EditProfileInfo({
    Key? key,
    this.userDTO,
  }) : super(key: key);

  @override
  _EditProfileInfoState createState() => _EditProfileInfoState();
}

class _EditProfileInfoState extends State<EditProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /** 유저명 */
        Row(
          children: [
            Expanded(
              child: const Text(
                '사용자 이름',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Notosans',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/setting/edit/profile/name');
              },
              child: Container(
                child: Row(
                  children: [
                    Text(
                      widget.userDTO?.userName ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 16,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Expanded(
              child: Text(
                '성별',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Notosans',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/setting/edit/profile/gender');
              },
              child: Container(
                child: Row(
                  children: [
                    Text(
                      widget.userDTO?.gender == 'male'
                          ? '남성'
                          : widget.userDTO?.gender == 'female'
                              ? '여성'
                              : '미설정',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'Notosans',
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 16,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Expanded(
              child: Text(
                '소개',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Notosans',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/setting/edit/profile/description');
              },
              child: Container(
                child: const Row(
                  children: [
                    Text(
                      '수정',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'Notosans',
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 16,
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
