import 'package:flutter/material.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class BoardGenderHeader extends StatefulWidget {
  final String gender;
  final ValueChanged<String> onGenderChanged;

  const BoardGenderHeader({
    Key? key,
    required this.gender,
    required this.onGenderChanged,
  }) : super(key: key);

  @override
  _BoardGenderHeaderState createState() => _BoardGenderHeaderState();
}

class _BoardGenderHeaderState extends State<BoardGenderHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      size: widget.gender == 'male' ? 28 : 20,
                      color: widget.gender == 'male'
                          ? Colors.blue
                          : AppColors.borderGray100Color,
                    ),
                    onPressed: () {
                      if (widget.gender != 'male') {
                        widget.onGenderChanged('male');
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
                      size: widget.gender == 'female' ? 28 : 20,
                      color: widget.gender == 'female'
                          ? AppColors.mainRedColor
                          : AppColors.borderGray100Color,
                    ),
                    onPressed: () {
                      if (widget.gender != 'female') {
                        widget.onGenderChanged('female');
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
