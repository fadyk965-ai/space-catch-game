import 'dart:math';
import 'package:flutter/material.dart';

/// Custom painter for rendering the animated starfield
class StarfieldPainter extends CustomPainter {
  final double progress;
  static final List<Point<double>> _stars = List.generate(
    30,
    (_) => Point(Random().nextDouble(), Random().nextDouble()),
  );

  StarfieldPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.3);
    for (var star in _stars) {
      double y = (star.y + progress) % 1.0;
      canvas.drawCircle(Offset(star.x * size.width, y * size.height), 1.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarfieldPainter oldDelegate) => true;
}

/// Widget that displays an animated starfield background
class AnimatedStarfieldBackground extends StatefulWidget {
  const AnimatedStarfieldBackground({super.key});

  @override
  State<AnimatedStarfieldBackground> createState() =>
      _AnimatedStarfieldBackgroundState();
}

class _AnimatedStarfieldBackgroundState extends State<AnimatedStarfieldBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bgController,
      builder: (context, child) {
        return CustomPaint(
          painter: StarfieldPainter(progress: _bgController.value),
        );
      },
    );
  }
}

