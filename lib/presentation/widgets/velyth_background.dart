import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class VelythBackground extends StatefulWidget {
  const VelythBackground({super.key});

  @override
  State<VelythBackground> createState() => _VelythBackgroundState();
}

class _VelythBackgroundState extends State<VelythBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<_Orb> _orbs = [
    // Radios gigantes para que sea "luz ambiental" y no "objetos"
    _Orb(color: AppTheme.primary, speed: 0.3, radius: 400, offset: 0),
    _Orb(color: Colors.blueAccent, speed: 0.2, radius: 350, offset: 2),
    _Orb(color: AppTheme.accent, speed: 0.4, radius: 300, offset: 4),
    // Un cuarto orbe oscuro para dar contraste en las esquinas
    _Orb(color: Colors.purpleAccent, speed: 0.1, radius: 450, offset: 5), 
  ];

  @override
  void initState() {
    super.initState();
    // 1. ULTRA SLOW MOTION
    // 60 segundos por ciclo. El movimiento es tan lento que es relajante.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60), 
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background, // Fondo negro base
      child: Stack(
        children: [
          // 1. Luces Ambientales (Orbes)
          ..._orbs.map((orb) => AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final t = _controller.value * 2 * math.pi + orb.offset;
              
              // 2. MOVIMIENTO AMPLIO PERO PERIFÉRICO
              // Usamos coordenadas grandes para que viajen muy lejos a las esquinas
              final x = math.sin(t * orb.speed) * 1.2; 
              final y = math.cos(t * orb.speed * 0.8) * 1.2;

              return Align(
                alignment: Alignment(x, y), 
                child: Container(
                  width: orb.radius * 2,
                  height: orb.radius * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // 3. SUTILEZA EXTREMA (Disimulado)
                    // Opacidad al 4%. Apenas tinta el negro.
                    color: orb.color.withOpacity(0.04), 
                    boxShadow: [
                      BoxShadow(
                        color: orb.color.withOpacity(0.05),
                        blurRadius: 150, // Desenfoque masivo (Neblina)
                        spreadRadius: 80,
                      )
                    ],
                  ),
                ),
              );
            },
          )),

          // 2. Vignette Fuerte (Enfoca la atención al centro oscureciendo bordes)
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.2,
                colors: [
                  Colors.transparent, // Centro limpio
                  Colors.black.withOpacity(0.4), // Bordes medios
                  Colors.black.withOpacity(0.9), // Esquinas muy oscuras
                ],
                stops: const [0.3, 0.8, 1.0], // Controla dónde empieza la oscuridad
              ),
            ),
          ),
          
          // 3. Glass Effect Final (Suavizado total)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: Container(color: Colors.transparent),
          ),
        ],
      ),
    );
  }
}

class _Orb {
  final Color color;
  final double speed;
  final double radius;
  final double offset;

  _Orb({
    required this.color,
    required this.speed,
    required this.radius,
    required this.offset,
  });
}