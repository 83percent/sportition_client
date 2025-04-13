import 'package:flutter/material.dart';
import 'package:sportition_client/models/users/user_dto.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class UserProfileComponent extends StatefulWidget {
  final UserDTO userDTO;
  const UserProfileComponent({Key? key, required this.userDTO})
      : super(key: key);

  @override
  _UserProfileComponentState createState() => _UserProfileComponentState();
}

class _UserProfileComponentState extends State<UserProfileComponent> {
  @override
  void initState() {
    super.initState();
  }

  String _league = 'GOLD';
  String _score = '324';
  String _workingOutDt = '5';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: [
          Row(
            children: [
              /* 사용자 이미지 */
              Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  color: AppColors.borderGray010Color,
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* 사용자명 */
                    Row(
                      children: [
                        Text(
                          widget.userDTO.userName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.fiber_manual_record,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ],
                    ),
                    /* // 사용자명 */
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      /* 리그 */
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.workspace_premium,
                                color: AppColors.borderGray100Color,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                _league,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        /* 운동 스코어 */
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.fitness_center,
                                color: AppColors.borderGray100Color,
                                size: 16,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                _score,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        /* 운동 일 수 */
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.local_fire_department,
                                color: Colors.orange,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                _workingOutDt,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
