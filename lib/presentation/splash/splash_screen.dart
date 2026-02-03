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
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();

    // Navegar al login
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const LoginScreen(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 1000),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Usamos las nuevas variables del tema Velyth (background, surface, primary)
    return Scaffold(
      backgroundColor: AppTheme.background, // <--- CORREGIDO
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- LOGO ANIMADO ---
            ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Column(
                  children: [
                    
Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.surface,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.3),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      // --- AQUÍ USAMOS TU NUEVO WIDGET ---
      child: VelythLogo(
        size: 70, // Tamaño
        color: AppTheme.primary, // Color verde neón automático
      ),
      // -----------------------------------
    ),
                    const SizedBox(height: 30),
                    Text(
                      'EQUUSTORE',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 4.0,
                        shadows: [
                          Shadow(
                            color: AppTheme.primary.withOpacity(0.6), // <--- CORREGIDO
                            blurRadius: 30,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 80),

            // --- BARRA DE CARGA TECH ---
            SizedBox(
              width: 200,
              child: Column(
                children: [
                  const LinearProgressIndicator(
                    backgroundColor: Colors.white10,
                    color: AppTheme.primary, // <--- CORREGIDO
                    minHeight: 2,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'LOADING MODULES...',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white30,
                      fontSize: 10,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            const Spacer(),
            
            // --- BRANDING VELYTH ---
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                children: [
                  Text(
                    'POWERED BY',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white38,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'VELYTH TECHNOLOGIES CORE',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.accent, // <--- CORREGIDO (Antes secondaryColor)
                      letterSpacing: 3.0,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: AppTheme.accent.withOpacity(0.4), // <--- CORREGIDO
                          blurRadius: 10,
                        )
                      ]
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}