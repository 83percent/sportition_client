import 'package:flutter/material.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class RecordHeader extends StatefulWidget {
  final int showIndex;
  final ValueChanged<int> onIndexChanged;

  const RecordHeader({
    Key? key,
    required this.showIndex,
    required this.onIndexChanged,
  }) : super(key: key);

  @override
  _RecordHeaderState createState() => _RecordHeaderState();
}

class _RecordHeaderState extends State<RecordHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: IconButton(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              onPressed: () {
                if (widget.showIndex != 0) {
                  widget.onIndexChanged(0);
                }
              },
              icon: Icon(
                Icons.query_stats,
                size: 28,
                color: widget.showIndex == 0
                    ? AppColors.mainRedColor
                    : AppColors.borderGray100Color,
              ),
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
              onPressed: () {
                if (widget.showIndex != 1) {
                  widget.onIndexChanged(1);
                }
              },
              icon: Icon(
                Icons.history,
                size: 28,
                color: widget.showIndex == 1
                    ? AppColors.mainRedColor
                    : AppColors.borderGray100Color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
