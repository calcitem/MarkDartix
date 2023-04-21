import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 40,
          height: 40,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: DotPainter(_animation.value, Colors.blue),
                ),
              ),
              Positioned.fill(
                child: CustomPaint(
                  painter:
                      DotPainter(1 - _animation.value, Colors.blue.withOpacity(0.4)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DotPainter extends CustomPainter {
  final double scale;
  final Color color;

  DotPainter(this.scale, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 * scale;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant DotPainter oldDelegate) {
    return oldDelegate.scale != scale;
  }
}
