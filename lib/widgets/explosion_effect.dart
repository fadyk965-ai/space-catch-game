import 'package:flutter/material.dart';
class ExplosionEffect extends StatefulWidget {
  const ExplosionEffect({super.key});

  @override
  State<ExplosionEffect> createState() => _ExplosionEffectState();
}

class _ExplosionEffectState extends State<ExplosionEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.5, end: 2.5).animate(_controller),
      child: FadeTransition(
        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(_controller),
        child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

