import '../registration.dart';

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.indicator
      ..strokeWidth = 2.0;

    Offset startPoint = Offset(18, size.height / 2);
    Offset endPoint = Offset(size.width - 18, size.height / 2);

    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
