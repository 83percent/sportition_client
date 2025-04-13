import 'package:flutter/material.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class BoardTypeHeader extends StatefulWidget {
  final String type;
  final ValueChanged<String> onTypeChanged;

  const BoardTypeHeader({
    Key? key,
    required this.type,
    required this.onTypeChanged,
  }) : super(key: key);

  @override
  _BoardTypeHeaderState createState() => _BoardTypeHeaderState();
}

class _BoardTypeHeaderState extends State<BoardTypeHeader> {
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
                      Icons.local_fire_department,
                      size: widget.type == 'continue' ? 28 : 20,
                      color: widget.type == 'continue'
                          ? Colors.orange
                          : AppColors.borderGray100Color,
                    ),
                    onPressed: () {
                      if (widget.type != 'continue') {
                        widget.onTypeChanged('continue');
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
                      Icons.fitness_center,
                      size: widget.type == 'exercise' ? 28 : 20,
                      color: widget.type == 'exercise'
                          ? Colors.black
                          : AppColors.borderGray100Color,
                    ),
                    onPressed: () {
                      if (widget.type != 'exercise') {
                        widget.onTypeChanged('exercise');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.borderGray010Color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
