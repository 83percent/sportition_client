import 'package:flutter/material.dart';
import 'package:sportition_client/models/boards/board_element_dto.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class BoardElement extends StatefulWidget {
  final BoardElementDTO boardElementDTO;

  const BoardElement({
    Key? key,
    required this.boardElementDTO,
  }) : super(key: key);

  @override
  _BoardElementState createState() => _BoardElementState();
}

class _BoardElementState extends State<BoardElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    widget.boardElementDTO.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSans',
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Icon(
                    Icons.fiber_manual_record,
                    color: widget.boardElementDTO.gender == 'male'
                        ? Colors.blue
                        : AppColors.mainRedColor,
                    size: 10,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                widget.boardElementDTO.league,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  const Icon(
                    Icons.local_fire_department,
                    color: Colors.orange,
                    size: 20,
                  ),
                  Text(widget.boardElementDTO.workingOutDt.toString()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
