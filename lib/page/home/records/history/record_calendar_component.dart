import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class RecordCalendarComponent extends StatefulWidget {
  final DateTime recordDate;
  final DateFormat formatter;
  final ValueChanged<DateTime> onMonthChanged;
  final ValueChanged<String> onDateChanged;

  const RecordCalendarComponent({
    Key? key,
    required this.recordDate,
    required this.formatter,
    required this.onMonthChanged,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  _RecordCalendarComponentState createState() =>
      _RecordCalendarComponentState();
}

class _RecordCalendarComponentState extends State<RecordCalendarComponent> {
  late int _lastDay = 31;
  String _activeDay = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _updateLastDay();
    _activeDay = widget.recordDate.day.toString();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToActiveDate();
    });
  }

  void _updateLastDay() {
    setState(() {
      _lastDay =
          DateTime(widget.recordDate.year, widget.recordDate.month + 1, 0).day;
    });
  }

  void _scrollToActiveDate() {
    // 예를 들어, activeDate가 리스트의 중간에 오도록 스크롤합니다.
    double position = _scrollController.position.maxScrollExtent / 2;
    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                onPressed: () {
                  setState(() {
                    _activeDay = '';
                    widget.onMonthChanged(DateTime(
                      widget.recordDate.year,
                      widget.recordDate.month - 1,
                      widget.recordDate.day,
                    ));
                    _updateLastDay();
                  });
                },
                icon: const Icon(
                  Icons.arrow_left,
                  color: AppColors.borderGray100Color,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.formatter
                    .format(widget.recordDate), // Record Search Date
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                onPressed: () {
                  setState(() {
                    _activeDay = '';
                    widget.onMonthChanged(DateTime(
                      widget.recordDate.year,
                      widget.recordDate.month + 1,
                      widget.recordDate.day,
                    ));
                    _updateLastDay();
                  });
                },
                icon: const Icon(
                  Icons.arrow_right,
                  color: AppColors.borderGray100Color,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        /* ========== '일' 선택 ========== */
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: Row(
            children: List.generate(
              DateTime(widget.recordDate.year, widget.recordDate.month + 1, 0)
                  .day,
              (index) {
                int day = index + 1;
                return Container(
                  width: 80,
                  alignment: Alignment.center,
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _activeDay = '$day';
                          widget.onDateChanged(_activeDay);
                        });
                      },
                      child: Text(
                        '$day',
                        style: _activeDay == '$day'
                            ? const TextStyle(
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              )
                            : const TextStyle(
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                color: AppColors.borderGray100Color,
                              ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          width: double.infinity,
          height: 10,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.borderGray100Color,
                width: 1,
              ),
            ),
          ),
        )
      ],
    );
  }
}
