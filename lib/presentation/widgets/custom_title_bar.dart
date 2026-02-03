import 'dart:ui'; // Necesario para ImageFilter
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. ClipRect para limitar el efecto de blur solo a la barra
    return ClipRect(
      child: BackdropFilter(
        // 2. El filtro de desenfoque (Glass Effect)
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            // 3. Color semitransparente (El "tinte" del cristal)
            color: AppTheme.background.withOpacity(0.5), 
            border: Border(
              bottom: BorderSide(
                color: AppTheme.primary.withOpacity(0.1), // Línea sutil
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              // --- ÁREA DE ARRASTRE ---
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onPanStart: (details) {
                    windowManager.startDragging();
                  },
                  onDoubleTap: () async {
                    if (await windowManager.isMaximized()) {
                      windowManager.unmaximize();
                    } else {
                      windowManager.maximize();
                    }
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      Icon(
                        Icons.hexagon_outlined, 
                        color: AppTheme.primary, 
                        size: 18
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'EQUUSTORE POS',
                        style: GoogleFonts.rajdhani(
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Badge versión
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppTheme.primary.withOpacity(0.3)),
                        ),
                        child: Text(
                          'V1.0',
                          style: GoogleFonts.robotoMono(
                            color: AppTheme.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // --- BOTONES ---
              const _WindowButton(icon: Icons.remove, action: WindowAction.minimize),
              const _WindowButton(icon: Icons.crop_square, action: WindowAction.maximize),
              const _WindowButton(icon: Icons.close, action: WindowAction.close, isClose: true),
            ],
          ),
        ),
      ),
    );
  }
}

// (El resto del código de los botones se mantiene igual que antes)
enum WindowAction { minimize, maximize, close }

class _WindowButton extends StatefulWidget {
  final IconData icon;
  final WindowAction action;
  final bool isClose;

  const _WindowButton({
    required this.icon,
    required this.action,
    this.isClose = false,
  });

  @override
  State<_WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<_WindowButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final hoverColor = widget.isClose 
        ? Colors.red.withOpacity(0.9) 
        : AppTheme.primary.withOpacity(0.2);
        
    final iconColor = widget.isClose && _isHovering 
        ? Colors.white 
        : (_isHovering ? AppTheme.primary : Colors.white54);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () async {
          switch (widget.action) {
            case WindowAction.minimize: windowManager.minimize(); break;
            case WindowAction.maximize:
              if (await windowManager.isMaximized()) windowManager.unmaximize();
              else windowManager.maximize();
              break;
            case WindowAction.close: windowManager.close(); break;
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 50,
          height: double.infinity,
          color: _isHovering ? hoverColor : Colors.transparent,
          child: Icon(widget.icon, size: 18, color: iconColor),
        ),
      ),
    );
  }
}