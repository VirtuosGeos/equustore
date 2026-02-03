import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class VelythBackground extends StatelessWidget {
  final Widget child;
  const VelythBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Fondo base
        Container(color: AppTheme.background),

        // 2. Orbe de luz ambiental (Arriba izquierda)
        Positioned(
          top: -100,
          left: -100,
          child: _buildOrb(AppTheme.accent, 400),
        ),

        // 3. Orbe de luz primaria (Abajo derecha)
        Positioned(
          bottom: -150,
          right: -50,
          child: _buildOrb(AppTheme.primary, 500),
        ),

        // 4. Patrón de rejilla sutil (Grid tecnológica)
        Positioned.fill(
          child: Opacity(
            opacity: 0.03,
            child: Image.network( // Un patrón de puntos simple
              'https://www.transparenttextures.com/patterns/black-scales.png',
              repeat: ImageRepeat.repeat,
            ),
          ),
        ),
        
        // 5. Desenfoque general para mezclar todo (Glass effect)
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
          child: Container(color: Colors.transparent),
        ),

        // 6. El contenido real de la app
        child,
      ],
    );
  }

  Widget _buildOrb(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.15),
      ),
    );
  }
}