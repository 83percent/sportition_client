import 'package:flutter/material.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CustomPaint(
              painter: SpeechBubblePainter(),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'There\'s nothing you can\'t do?',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.red,
                    height: 0.9,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Text(
              'SPORTITION ',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w800,
                fontSize: 50,
                color: Colors.white,
                background: Paint()
                  ..color = AppColors.mainRedColor
                  ..style = PaintingStyle.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SpeechBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = AppColors.mainRedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final path = Path()
      ..moveTo(20, 0)
      ..lineTo(size.width - 20, 0)
      ..quadraticBezierTo(size.width, 0, size.width, 20)
      ..lineTo(size.width, size.height - 20)
      ..quadraticBezierTo(size.width, size.height, size.width - 20, size.height)
      ..lineTo(size.width / 2 + 10, size.height)
      ..lineTo(size.width / 2, size.height + 20)
      ..lineTo(size.width / 2 - 10, size.height)
      ..lineTo(20, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - 20)
      ..lineTo(0, 20)
      ..quadraticBezierTo(0, 0, 20, 0)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
