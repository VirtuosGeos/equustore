// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart'; // Importante
import 'core/theme/app_theme.dart';
import 'presentation/splash/splash_screen.dart';
import 'package:equustore/core/utils/platform_utils.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));

  // Solo ejecutar configuración de ventana si es Desktop
  if (isDesktop) {
    doWhenWindowReady(() {
      final win = appWindow;
      const initialSize = Size(1280, 720);
      win.minSize = const Size(1024, 768);
      win.size = initialSize;
      win.alignment = Alignment.center;
      win.title = "EquuStore POS";
      win.show();
    });
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EquuStore POS',
      theme: AppTheme.velythTheme,
      home: const SplashScreen(),
    );
  }
}