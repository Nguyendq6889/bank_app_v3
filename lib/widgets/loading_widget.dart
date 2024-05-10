import 'package:flutter/material.dart';
// import '../app_assets/app_colors.dart';
import "dart:math";

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
        // child: const CircularProgressIndicator(
        //   strokeWidth: 2,
        //   color: AppColors.primaryColor,
        // ),
        child: const LoadingAnimationWidget(),
      )
    );
  }
}


class LoadingAnimationWidget extends StatefulWidget {
  const LoadingAnimationWidget({super.key});

  @override
  State<LoadingAnimationWidget> createState() => _LoadingWidget2State();
}

class _LoadingWidget2State extends State<LoadingAnimationWidget> with TickerProviderStateMixin {
  late Animation<double> animation1;
  late Animation<double> animation2;
  late AnimationController controller1;
  late AnimationController controller2;
  final double loadingSize = 40;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);

    controller2 = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);
    

    // animation1 = Tween<double>(begin: 0, end: 1).animate(
    //     CurvedAnimation(parent: controller1, curve: Curves.decelerate));
    //
    animation2 = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller2,
        curve: const Interval(0, 1, curve: Curves.decelerate),
      )
    );

    animation1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller1,
        curve: const Interval(0, 1, curve: Curves.decelerate),
      )
    );

    controller1.repeat();
    controller2.repeat();
  }

  @override
  Widget build(BuildContext context) => Center(
    child: Stack(
      children: <Widget>[
        RotationTransition(
          turns: animation1,
          child: CustomPaint(
            painter: Arc1Painter(Color(0xff216BF8)),
            child: SizedBox(
              width: loadingSize,
              height: loadingSize,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2),
          child: RotationTransition(
            turns: animation2,
            child: CustomPaint(
              painter: Arc2Painter(Color(0xff89B9F6)),
              child: SizedBox(
                width: loadingSize,
                height: loadingSize,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }
}

class Arc1Painter extends CustomPainter {
  final Color color;

  Arc1Painter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p1 = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Rect rect1 = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawArc(rect1, 0, 1.5 * pi, false, p1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Arc2Painter extends CustomPainter {
  final Color color;

  Arc2Painter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p2 = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Rect rect2 = Rect.fromLTWH(
        0.0 + (0.2 * size.width) / 2,
        0.0 + (0.2 * size.height) / 2,
        size.width - 0.2 * size.width,
        size.height - 0.2 * size.height);

    canvas.drawArc(rect2, 0, 1.5 * pi, false, p2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
