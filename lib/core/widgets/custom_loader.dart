// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math show sin, pi;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messenger/core/theme/app_colors.dart';
import 'package:messenger/core/theme/app_images.dart';
import 'package:messenger/core/widgets/custom_image_view.dart';

class CircularLoader extends StatelessWidget {
  const CircularLoader({super.key, this.radius, this.color, this.strokeWidth});
  final double? radius;
  final double? strokeWidth;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: radius,
      width: radius,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth ?? 4,
          color: color ?? AppColors.primary,
        ),
      ),
    );
  }
}

class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
    this.radius,
    this.color,
    this.strokeWidth,
    this.backgroundColor,
  });
  final double? radius;
  final double? strokeWidth;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? AppColors.text1.withValues(alpha: 0.1),
      child: Center(
        child: SizedBox(
          height: radius,
          width: radius,
          child: Center(
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: 80.r,
                    width: 80.r,
                    child: Center(
                      child: CircleAvatar(
                        radius: 34.r,
                        backgroundColor: AppColors.primary,
                        child: CustomImageView(svgPath: AppImages.messageIcon),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SpinKitDualRing(
                    color: AppColors.primary,
                    size: 85.r,
                    lineWidth: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppLoaderWithChild extends StatelessWidget {
  const AppLoaderWithChild({super.key, this.child, this.isLoading = false});
  final Widget? child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          child ?? const SizedBox(),
          if (isLoading) ...[AppLoader()],
        ],
      ),
    );
  }
}

class SpinKitDualRing extends StatefulWidget {
  const SpinKitDualRing({
    super.key,
    required this.color,
    this.lineWidth = 7.0,
    this.size = 50.0,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
  });

  final Color color;
  final double lineWidth;
  final double size;
  final Duration duration;
  final AnimationController? controller;

  @override
  State<SpinKitDualRing> createState() => _SpinKitDualRingState();
}

class _SpinKitDualRingState extends State<SpinKitDualRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller =
        (widget.controller ??
              AnimationController(vsync: this, duration: widget.duration))
          ..addListener(() {
            if (mounted) {
              setState(() {});
            }
          })
          ..repeat();
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform(
        transform: Matrix4.identity()
          ..rotateZ((_animation.value) * math.pi * 2),
        alignment: FractionalOffset.center,
        child: CustomPaint(
          painter: _DualRingPainter(
            angle: 90,
            paintWidth: widget.lineWidth,
            color: widget.color,
          ),
          child: SizedBox.fromSize(size: Size.square(widget.size)),
        ),
      ),
    );
  }
}

class _DualRingPainter extends CustomPainter {
  _DualRingPainter({
    required this.angle,
    required double paintWidth,
    required Color color,
  }) : ringPaint = Paint()
         ..color = color
         ..strokeWidth = paintWidth
         ..style = PaintingStyle.stroke;

  final Paint ringPaint;
  final double angle;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromPoints(Offset.zero, Offset(size.width, size.height));
    canvas.drawArc(rect, 0.0, getRadian(angle), false, ringPaint);
    canvas.drawArc(rect, getRadian(180.0), getRadian(angle), false, ringPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  double getRadian(double angle) => math.pi / 180 * angle;
}

class DelayTween extends Tween<double> {
  DelayTween({super.begin, super.end, required this.delay});

  final double delay;

  @override
  double lerp(double t) {
    return super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);
  }

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
