import 'package:flutter/material.dart';
import 'package:sportition_client/page/home/boards/board_continue/board_continue_page.dart';
import 'package:sportition_client/page/home/boards/board_exercise/board_exercise_page.dart';
import 'package:sportition_client/page/home/boards/board_header/board_type_header.dart';

/* 리더보드 */
class BoardPage extends StatefulWidget {
  final String userUID;
  const BoardPage({Key? key, required this.userUID}) : super(key: key);

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  int index = 0;
  String type = 'exercise';

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          BoardTypeHeader(
              type: type,
              onTypeChanged: (newType) {
                setState(() {
                  type = newType;
                  switch (newType) {
                    case 'exercise':
                      index = 0;
                      break;
                    case 'continue':
                      index = 1;
                      break;
                    default:
                      index = 0;
                      break;
                  }
                });
              }),
          Expanded(
            child: IndexedStack(
              index: index,
              children: const [
                BoardExercisePage(),
                BoardContinuePage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
