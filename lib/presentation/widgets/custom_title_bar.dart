// lib/presentation/widgets/custom_title_bar.dart
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import '../../core/theme/app_theme.dart';

class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Row(
        children: [
          // 1. ZONA DE ARRASTRE (Izquierda)
          Expanded(
            child: MoveWindow(
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  // Pequeño logo en la barra
                  const Icon(Icons.storefront, 
                      color: AppTheme.primary, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'EQUUSTORE POS',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                  ),
                ],
              ),
            ),
          ),

          // 2. BOTONES DE VENTANA (Derecha)
          const WindowButtons(),
        ],
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    // Definimos los colores para el estado normal y hover
    final buttonColors = WindowButtonColors(
      iconNormal: Colors.white54,
      mouseOver: AppTheme.primary.withOpacity(0.1),
      mouseDown: AppTheme.primary.withOpacity(0.2),
      iconMouseOver: AppTheme.primary,
      iconMouseDown: AppTheme.primary,
    );

    final closeButtonColors = WindowButtonColors(
      mouseOver: const Color(0xFFD32F2F),
      mouseDown: const Color(0xFFB71C1C),
      iconNormal: Colors.white54,
      iconMouseOver: Colors.white,
    );

    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}