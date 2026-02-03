import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../auth/login_screen.dart';
import '../widgets/velyth_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Controlador para la transición suave
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _startSequence();
  }

  Future<void> _startSequence() async {
    // 1. Aparecer (Fade In)
    await _controller.forward();
    
    // 2. Esperar leyendo el logo (Hold)
    await Future.delayed(const Duration(seconds: 2));

    // 3. Desvanecer a Negro (Fade Out)
    if (mounted) {
      await _controller.reverse(); 
    }

    // 4. Navegar
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LoginScreen(),
          transitionDuration: const Duration(milliseconds: 1000),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: FadeTransition(
        opacity: _opacityAnimation,
        child: Stack(
          children: [
            // 1. CONTENIDO CENTRAL
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Velyth
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primary.withOpacity(0.3),
                                blurRadius: 80,
                                spreadRadius: -10,
                              ),
                            ],
                          ),
                        ),
                        const VelythLogo(
                          size: 90,
                          color: AppTheme.primary,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 50),
                    
                    Text(
                      'EQUUSTORE',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 8.0,
                        fontSize: 24,
                      ),
                    ),

                    const SizedBox(height: 60),

                    // --- BARRA DE PROGRESO (Regreso triunfal) ---
                    SizedBox(
                      width: 160, // Ancho controlado y elegante
                      child: Column(
                        children: [
                          LinearProgressIndicator(
                            backgroundColor: Colors.white10, // Fondo sutil
                            color: AppTheme.primary, // Verde Velyth
                            minHeight: 2, // Muy fina y minimalista
                            borderRadius: BorderRadius.circular(2),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'LOADING SYSTEM...',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppTheme.primary.withOpacity(0.8),
                              fontSize: 9,
                              letterSpacing: 2.5, // Espaciado técnico
                              fontFamily: 'JetBrains Mono',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. FOOTER
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'powered by',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white24,
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'VELYTH TECHNOLOGIES CORE',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppTheme.accent,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        shadows: [
                          Shadow(
                            color: AppTheme.accent.withOpacity(0.3),
                            blurRadius: 10,
                          )
                        ]
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}