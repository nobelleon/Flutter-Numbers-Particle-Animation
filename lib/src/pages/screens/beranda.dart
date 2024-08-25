import 'dart:math';

import 'package:flutter/material.dart';

import '../../widgets/particle.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> with TickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _controller.addListener(() {
      setState(() {
        _particles.removeWhere((particle) => particle.isDead);
        for (var particle in _particles) {
          particle.update();
        }
      });
    });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[200],
      body: GestureDetector(
        onTap: () {
          _generateParticles();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomPaint(
              size: Size(double.infinity, MediaQuery.of(context).size.height),
              painter: ParticlePainter(particles: _particles),
            ),
          ],
        ),
      ),
    );
  }

  void _generateParticles() {
    final random = Random();
    final numParticles = random.nextInt(30) + 10;

    for (int i = 0; i < numParticles; i++) {
      final particle = Particle(
        position: Offset(
          MediaQuery.of(context).size.width / 2,
          MediaQuery.of(context).size.height / 3,
        ),
        velocity: Offset(
          random.nextDouble() * 6 - 3,
          -random.nextDouble() * 10 - 5,
        ),
        acceleration: const Offset(0, 0.5),
        size: random.nextDouble() * 50 + 10,
        lifespan: Duration(milliseconds: random.nextInt(500) + 500),
        rotation: random.nextDouble() * 2 * pi,
        rotationSpeed: random.nextDouble() * 0.2 - 0.1,
        color: Colors.primaries[random.nextInt(Colors.primaries.length)],
        number: random.nextInt(10),
      );
      _particles.add(particle);
    }
  }
}
