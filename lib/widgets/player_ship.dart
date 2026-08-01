import 'package:flutter/material.dart';
import 'thrust_flame_painter.dart';

/// Widget that displays the player's ship with optional shield
class PlayerShipWidget extends StatelessWidget {
  final bool hasShield;

  const PlayerShipWidget({
    super.key,
    required this.hasShield,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: hasShield ? const Color(0xFF06B6D4) : const Color(0xFF6366F1),
            shape: BoxShape.circle,
            border: hasShield ? Border.all(color: Colors.white, width: 3) : null,
            boxShadow: [
              BoxShadow(
                color: (hasShield ? const Color(0xFF06B6D4) : const Color(0xFF6366F1))
                    .withOpacity(0.8),
                blurRadius: 18,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Icon(
            hasShield ? Icons.security_rounded : Icons.navigation_rounded,
            color: Colors.white,
            size: 34,
          ),
        ),
        const CustomPaint(
          size: Size(20, 15),
          painter: ThrustFlamePainter(),
        ),
      ],
    );
  }
}

