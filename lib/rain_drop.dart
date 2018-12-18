import 'package:flutter/rendering.dart';

class RainDrop extends CustomPainter {
  RainDrop(this.rainList);

  List<RainDropDrawer> rainList = List();
  Paint  _paint = new Paint()..style = PaintingStyle.stroke;
  @override
  void paint(Canvas canvas, Size size) {
    rainList.forEach((item) {
      item.drawRainDrop(canvas, _paint);
    });
    rainList.removeWhere((item) {
      return !item.isValid();
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class RainDropDrawer {
  static const double MAX_RADIUS = 30;
  double posX;
  double posY;
  double radius = 5;

  RainDropDrawer(this.posX, this.posY);

  drawRainDrop(Canvas canvas, Paint paint) {
    double opt = (MAX_RADIUS - radius) / MAX_RADIUS;
    paint.color = Color.fromRGBO(0, 0, 0, opt);
    canvas.drawCircle(Offset(posX, posY), radius, paint);
    radius += 1;
  }

  bool isValid() {
    return radius < MAX_RADIUS;
  }

}