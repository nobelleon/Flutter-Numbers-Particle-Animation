import 'package:flutter/material.dart';

class Particle {
  Offset position;
  Offset velocity;
  Offset acceleration;
  double size;
  Duration lifespan;
  bool isDead = false;
  double rotation;
  double rotationSpeed;
  Color color;
  int number;

  Particle({
    required this.position,
    required this.velocity,
    required this.acceleration,
    required this.size,
    required this.lifespan,
    required this.rotation,
    required this.rotationSpeed,
    required this.color,
    required this.number,
  });

  void update() {
    velocity += acceleration;
    position += velocity;
    rotation += rotationSpeed;
    lifespan -= const Duration(milliseconds: 16);
    if (lifespan <= Duration.zero) {
      isDead = true;
    }
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (var particle in particles) {
      paint.color =
          particle.color.withOpacity(particle.lifespan.inMilliseconds / 1000);
      canvas.save();
      canvas.translate(particle.position.dx, particle.position.dy);
      canvas.rotate(particle.rotation);
      canvas.drawCircle(Offset.zero, particle.size, paint);
      final textStyle = TextStyle(
        color: Colors.pink,
        fontSize: particle.size * 0.8,
        fontWeight: FontWeight.bold,
      );
      final textSpan = TextSpan(
        text: particle.number.toString(),
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(-particle.size / 2, -particle.size / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
