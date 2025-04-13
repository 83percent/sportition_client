import 'package:flutter/material.dart';
import 'package:sportition_client/page/home/boards/board_exercise/board_exercise_header.dart';
import 'package:sportition_client/page/home/boards/board_exercise/board_gender_header.dart';
import 'package:sportition_client/services/user/user_service.dart';

class BoardExercisePage extends StatefulWidget {
  const BoardExercisePage({Key? key}) : super(key: key);

  @override
  _BoardExercisePageState createState() => _BoardExercisePageState();
}

class _BoardExercisePageState extends State<BoardExercisePage> {
  String gender = 'unset';
  String exerciseType = 'All';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _initializeGender() async {
    final userDTO = await UserService().getUserDTO();
    if (userDTO.gender != '') {
      setState(() {
        gender = userDTO.gender;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          BoardGenderHeader(
            gender: gender,
            onGenderChanged: (newGender) {
              setState(() {
                gender = newGender;
              });
            },
          ),
          BoardExerciseHeader(
            exerciseType: exerciseType,
          ),
        ],
      ),
    );
  }
}
