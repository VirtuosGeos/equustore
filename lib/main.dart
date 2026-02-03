import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart'; // <--- NUEVO IMPORT
import 'core/theme/app_theme.dart';
import 'presentation/splash/splash_screen.dart';

  // Configuración de la ventana
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 720), // Tamaño inicial
    // --- LÍMITE MÍNIMO DE SEGURIDAD ---
    minimumSize: Size(1024, 768), // El usuario no podrá encogerla menos que esto
    // ----------------------------------
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const ProviderScope(child: MainApp()));
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