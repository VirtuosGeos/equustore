import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:equustore/core/theme/app_theme.dart';
import 'package:equustore/core/utils/platform_utils.dart';
import '../widgets/custom_title_bar.dart';
import '../widgets/velyth_background.dart'; // Importamos el fondo

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VelythBackground( // Usamos nuestro fondo nuevo
        child: Column(
          children: [
            if (isDesktop) const CustomTitleBar(),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildBrandHeader(context),
                          const SizedBox(height: 50),
                          _buildGlassCard(context),
                          const SizedBox(height: 40),
                          _buildTechFooter(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandHeader(BuildContext context) {
    return Column(
      children: [
        // Icono Abstracto
        Icon(Icons.hexagon_outlined, size: 60, color: AppTheme.primary),
        const SizedBox(height: 10),
        Text(
          'EQUUSTORE',
          style: Theme.of(context).textTheme.displayLarge, 
        ),
        Text(
          'POS SYSTEM /// V.1.0',
          style: Theme.of(context).textTheme.labelLarge, // Estilo monoespaciado
        ),
      ],
    );
  }

  Widget _buildGlassCard(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Efecto Cristal
        child: Container(
          width: 420, // Un poco más ancho para desktop
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: AppTheme.surface.withOpacity(0.6), // Fondo semitransparente
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('ACCESS CONTROL', 
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white54
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'OPERATOR ID',
                  prefixIcon: Icon(Icons.qr_code_2), // Icono más técnico
                ),
              ),
              const SizedBox(height: 20),
              
              TextFormField(
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'SECURITY KEY',
                  prefixIcon: Icon(Icons.password),
                ),
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {},
                child: const Text('INITIALIZE SESSION'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechFooter(BuildContext context) {
    return Column(
      children: [
        Text(
          'SECURED BY',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.security, size: 14, color: AppTheme.primary),
            const SizedBox(width: 6),
            Text(
              'VELYTH TECHNOLOGIES CORE',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}