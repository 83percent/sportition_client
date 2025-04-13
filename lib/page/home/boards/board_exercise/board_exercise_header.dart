import 'package:flutter/material.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class BoardExerciseHeader extends StatefulWidget {
  String? exerciseType;
  BoardExerciseHeader({Key? key, required this.exerciseType}) : super(key: key);

  @override
  _BoardExerciseHeaderState createState() => _BoardExerciseHeaderState();
}

class _BoardExerciseHeaderState extends State<BoardExerciseHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                setState(() {
                  widget.exerciseType = 'all';
                });
              },
              child: Text(
                'All',
                style: TextStyle(
                  color: widget.exerciseType == 'all'
                      ? Colors.black
                      : AppColors.borderGray100Color,
                ),
              ),
            ),
          ),
          Container(
            width: 1,
            height: 20,
            margin: const EdgeInsets.symmetric(
              horizontal: 3,
            ),
            decoration: const BoxDecoration(
              color: AppColors.borderGray100Color,
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                setState(() {
                  widget.exerciseType = 'squat';
                });
              },
              child: Text(
                '스쿼트',
                style: TextStyle(
                  color: widget.exerciseType == 'squat'
                      ? Colors.black
                      : AppColors.borderGray100Color,
                ),
              ),
            ),
          ),
          Container(
            width: 1,
            height: 20,
            margin: const EdgeInsets.symmetric(
              horizontal: 3,
            ),
            decoration: const BoxDecoration(
              color: AppColors.borderGray100Color,
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                setState(() {
                  widget.exerciseType = 'deadlift';
                });
              },
              child: Text(
                '데드리프트',
                style: TextStyle(
                  color: widget.exerciseType == 'deadlift'
                      ? Colors.black
                      : AppColors.borderGray100Color,
                ),
              ),
            ),
          ),
          Container(
            width: 1,
            height: 20,
            margin: const EdgeInsets.symmetric(
              horizontal: 3,
            ),
            decoration: const BoxDecoration(
              color: AppColors.borderGray100Color,
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                setState(() {
                  widget.exerciseType = 'benchpress';
                });
              },
              child: Text(
                '벤치 프레스',
                style: TextStyle(
                  color: widget.exerciseType == 'benchpress'
                      ? Colors.black
                      : AppColors.borderGray100Color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
