// lib/presentation/widgets/velyth_logo.dart
import 'package:flutter/material.dart';

class VelythLogo extends StatelessWidget {
  final double size;
  final Color color;

  const VelythLogo({
    super.key, 
    required this.size, 
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CatHeadPainter(color: color),
    );
  }
}

class _CatHeadPainter extends CustomPainter {
  final Color color;
  _CatHeadPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke // Solo el borde (estilo Tech)
      ..strokeWidth = size.width * 0.08 // Grosor relativo al tamaño
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;
    final path = Path();

    // DIBUJO DEL GATO GEOMÉTRICO (Coordenadas relativas 0.0 a 1.0)
    
    // 1. Empezamos en la oreja izquierda (punta)
    path.moveTo(w * 0.2, h * 0.1); 
    
    // 2. Bajamos por la oreja interna izquierda
    path.lineTo(w * 0.35, h * 0.35);
    
    // 3. Puente de la frente
    path.lineTo(w * 0.65, h * 0.35);
    
    // 4. Subimos a la oreja derecha (punta)
    path.lineTo(w * 0.8, h * 0.1);
    
    // 5. Bajamos por el lado derecho de la cara
    path.lineTo(w * 0.85, h * 0.6);
    
    // 6. Mentón (punta afilada hacia abajo)
    path.lineTo(w * 0.5, h * 0.9);
    
    // 7. Subimos por el lado izquierdo
    path.lineTo(w * 0.15, h * 0.6);
    
    // 8. Cerramos en la oreja izquierda
    path.close();

    // Dibujamos el contorno
    canvas.drawPath(path, paint);

    // Ojos (Detalle Tech)
    final eyePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
      
    // Ojo Izquierdo
    canvas.drawCircle(Offset(w * 0.40, h * 0.55), w * 0.04, eyePaint);
    // Ojo Derecho
    canvas.drawCircle(Offset(w * 0.60, h * 0.55), w * 0.04, eyePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}