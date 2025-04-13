import 'package:flutter/material.dart';
import 'package:sportition_client/models/users/user_dto.dart';
import 'package:sportition_client/page/settings/edit_profile/edit_profile_image.dart';
import 'package:sportition_client/page/settings/edit_profile/edit_profile_info.dart';
import 'package:sportition_client/services/user/user_service.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  UserDTO? _userDTO;
  late Future<void> _initializeUserDTOFuture;

  @override
  void initState() {
    super.initState();
    _initializeUserDTOFuture = _initializeUserDTO();
  }

  Future<void> _initializeUserDTO() async {
    final userDTO = await UserService().getUserDTO();
    setState(() {
      _userDTO = userDTO;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeUserDTOFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: Text('오류가 발생했습니다.')),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text(
                '프로필 수정',
                style: TextStyle(
                  fontSize: 19,
                  fontFamily: 'Notosans',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  if (_userDTO != null)
                    EditProfileImage(imageId: _userDTO?.imageId),
                  const SizedBox(height: 20),
                  EditProfileInfo(userDTO: _userDTO),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
