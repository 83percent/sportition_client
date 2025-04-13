import 'package:flutter/material.dart';

class AlertComponent extends StatefulWidget {
  final String message;

  const AlertComponent({Key? key, required this.message}) : super(key: key);

  @override
  _AlertComponentState createState() => _AlertComponentState();
}

class _AlertComponentState extends State<AlertComponent> {
  double _alertOffset = 71;

  @override
  void didUpdateWidget(AlertComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.message.isNotEmpty) {
      setState(() {
        _alertOffset = 0;
      });

      // 3초 후에 다시 원래 위치로 돌아가도록 설정
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted && widget.message.isNotEmpty) {
          setState(() {
            _alertOffset = 61;
          });
        }
      });
    } else {
      setState(() {
        _alertOffset = 71;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 200,
      ),
      transform: Matrix4.translationValues(0, _alertOffset, 0),
      width: double.infinity,
      height: 60,
      color: Colors.red,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Text(
        widget.message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'NotoSansKR',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
