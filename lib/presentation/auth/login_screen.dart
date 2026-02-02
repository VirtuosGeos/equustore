// lib/presentation/auth/login_screen.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/custom_title_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// Usamos SingleTickerProviderStateMixin para el controlador de animación
class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Configuración del controlador principal
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200), // Duración total de la entrada
    );

    // 2. Definir la animación de desvanecimiento (Opacidad de 0 a 1)
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // 3. Definir la animación de desplazamiento (Se mueve de abajo hacia arriba)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1), // Empieza un 10% más abajo
      end: Offset.zero, // Termina en su posición original
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // Iniciar la animación al cargar la pantalla
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Limpiar el controlador para evitar fugas de memoria
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Quitamos el AppBar nativo si hubiera
      body: Column(
        children: [
          // AQUI PONEMOS NUESTRA BARRA PERSONALIZADA
          const CustomTitleBar(),
          
          // El resto del contenido llena el espacio sobrante
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                // ... (El resto de tu código del Login sigue igual aquí adentro)
                child: Center(
                  child: SingleChildScrollView(
                    // ... el contenido de tu login anterior ...
                    child: Padding(
                       padding: const EdgeInsets.all(24.0),
                       child: Column(
                         // ... tus widgets de login ...
                         children: [
                            _buildHeader(context),
                            const SizedBox(height: 40),
                            _buildLoginCard(context),
                            const SizedBox(height: 40),
                            _buildFooter(context),
                         ]
                       )
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // He separado los widgets en métodos para mantener el código limpio

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'EQUUSTORE',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 2.0,
            shadows: [
              Shadow(
                color: AppTheme.primaryColor.withOpacity(0.5),
                blurRadius: 20,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        ),
        Text(
          'COFFEE & MARKET',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppTheme.primaryColor,
            letterSpacing: 4.0,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard(BuildContext context) {
    return Container(
      width: 400, // Ancho fijo para escritorio
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Bienvenido',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Usuario',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 20),
          
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: Icon(Icons.lock_outline),
            ),
          ),
          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Iniciando sesión...')),
              );
            },
            child: const Text('INICIAR SESIÓN'),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Text(
          'Powered by',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white30,
          ),
        ),
        const SizedBox(height: 4),
        // AQUI ESTÁ TU MARCA CON UN ESTILO TECH
        Text(
          'VELYTH TECHNOLOGIES CORE',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppTheme.secondaryColor, // Usamos el color secundario
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'v0.1.0 Beta',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white30,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}