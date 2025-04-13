import 'package:flutter/material.dart';
import 'package:sportition_client/models/users/user_dto.dart';
import 'package:sportition_client/page/home/users/centers/user_center.dart';
import 'package:sportition_client/page/home/users/contents/user_content.dart';
import 'package:sportition_client/page/home/users/user_description.dart';
import 'package:sportition_client/page/home/users/user_header.dart';
import 'package:sportition_client/page/home/users/user_profile_component.dart';
import 'package:sportition_client/page/home/users/user_profile_edit_button.dart';
import 'package:sportition_client/services/user/user_service.dart';

class UserPage extends StatefulWidget {
  final String userUID;
  const UserPage({Key? key, required this.userUID}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late Future<UserDTO> _userDTO;

  @override
  void initState() {
    super.initState();
    _userDTO = _fetchUserDTO();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userDTO = _fetchUserDTO();
  }

  Future<UserDTO> _fetchUserDTO() async {
    return await UserService().getUserDTO();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDTO>(
      future: _userDTO,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          UserDTO userDTO = snapshot.data!;
          return Column(
            children: [
              const SizedBox(height: 50),
              // 설정 버튼
              const UserHeader(),
              // 프로필
              UserProfileComponent(userDTO: userDTO),
              // Description
              if (userDTO.description != null &&
                  userDTO.description!.isNotEmpty)
                UserDescription(description: userDTO.description!),
              const SizedBox(height: 5),
              // 프로필 수정 버튼
              const UserProfileEditButton(),
              const SizedBox(height: 20),
              UserCenter(),
              const SizedBox(height: 20),
              const UserContent(),
            ],
          );
        } else {
          return const Center(child: Text('No data'));
        }
      },
    );
  }
}
