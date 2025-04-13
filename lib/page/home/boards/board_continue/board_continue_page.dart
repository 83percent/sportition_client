import 'package:flutter/material.dart';
import 'package:sportition_client/models/boards/board_element_dto.dart';
import 'package:sportition_client/page/home/boards/board_continue/board_element.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class BoardContinuePage extends StatefulWidget {
  const BoardContinuePage({Key? key}) : super(key: key);

  @override
  _BoardContinuePageState createState() => _BoardContinuePageState();
}

class _BoardContinuePageState extends State<BoardContinuePage> {
  final List<BoardElementDTO> elements = List.generate(
    100,
    (index) => BoardElementDTO(
      uid: 'uid_$index',
      name: 'User $index',
      league: 'GOLD',
      workingOutDt: index,
      score: index * 10,
      squart: index * 5,
      benchPress: index * 3,
      deadLift: index * 2,
      gender: 'female',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: elements.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(
                      color: AppColors.borderGray010Color,
                      width: 1,
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                alignment: Alignment.center,
                child: Text(
                  index.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              Expanded(
                child: BoardElement(
                  boardElementDTO: elements[index],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
