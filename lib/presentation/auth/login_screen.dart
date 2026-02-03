import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import '../../core/theme/app_theme.dart';
import '../widgets/velyth_background.dart';
import '../widgets/custom_title_bar.dart';
import '../widgets/tech_input_field.dart'; // <--- Asegúrate de que este import funcione

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. FONDO CON ORBES (Capa trasera)
          const Positioned.fill(
            child: VelythBackground(),
          ),

          // 2. CONTENIDO PRINCIPAL (Capa media)
          Positioned.fill(
            child: Column(
              children: [
                // Barra Superior (Título y botones de ventana)
                const CustomTitleBar(),
                
                // Tarjeta Central (Login)
                // Usamos Expanded para que ocupe el espacio sobrante y centre verticalmente
                Expanded(
                  child: Center(
                    child: _buildGlassCard(context),
                  ),
                ),
              ],
            ),
          ),

          // 3. BARRA DE ESTADO INFERIOR (Capa delantera)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildStatusBar(context),
          ),
        ],
      ),
    );
  }

  // --- TARJETA DE LOGIN (CON TECH INPUTS) ---
  Widget _buildGlassCard(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: 420, // Ancho cómodo para escritorio
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
          decoration: BoxDecoration(
            color: AppTheme.surface.withOpacity(0.6), // Fondo semitransparente
            border: Border.all(color: Colors.white.withOpacity(0.08)), // Borde sutil
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 30,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. HEADER (Icono y Saludo)
              Icon(
                Icons.hexagon_outlined, 
                size: 40, 
                color: AppTheme.primary.withOpacity(0.8)
              ),
              const SizedBox(height: 16),
              
              Text(
                'WELCOME BACK',
                textAlign: TextAlign.center,
                style: GoogleFonts.rajdhani(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'SYSTEM READY TO AUTHENTICATE', 
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white38,
                  letterSpacing: 2.0,
                  fontSize: 10,
                  fontWeight: FontWeight.w600
                ),
              ),

              const SizedBox(height: 40),
              
              // 2. NUEVOS CAMPOS ANIMADOS (TechInputField)
              const TechInputField(
                label: 'Operator Identity',
                icon: Icons.badge, 
              ),
              
              const SizedBox(height: 25), // Espacio entre campos
              
              const TechInputField(
                label: 'Security Clearance',
                icon: Icons.lock,
                isPassword: true,
              ),
              
              const SizedBox(height: 40),

              // 3. BOTÓN DE ACCIÓN (AUTHENTICATE)
              ElevatedButton(
                onPressed: () {
                    // AQUÍ PONDREMOS LA LÓGICA DE VALIDACIÓN LUEGO
                    print("Intentando autenticar...");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), // Bordes más rectos (Tech)
                  elevation: 0, 
                  shadowColor: Colors.transparent, 
                ),
                child: Text(
                  'AUTHENTICATE ACCESS', 
                  style: GoogleFonts.robotoMono(
                    fontWeight: FontWeight.bold, 
                    letterSpacing: 1.5,
                    fontSize: 14
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- BARRA DE ESTADO (Footer) ---
  Widget _buildStatusBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A).withOpacity(0.9), // Casi negro sólido para legibilidad
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Izquierda: Nodo
          Row(
            children: [
              Icon(Icons.dns, size: 14, color: Colors.white.withOpacity(0.3)),
              const SizedBox(width: 8),
              Text(
                'TERMINAL: NODE-01',
                style: GoogleFonts.robotoMono(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 10,
                ),
              ),
            ],
          ),
          
          // Centro: Versión
          Text(
            'VELYTH CORE V1.0.4 [STABLE]',
            style: GoogleFonts.robotoMono(
              color: Colors.white.withOpacity(0.2),
              fontSize: 10,
            ),
          ),
          
          // Derecha: Link Status
          Row(
            children: [
              Text(
                'SERVER LINK',
                style: GoogleFonts.robotoMono(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 10,
                ),
              ),
              const SizedBox(width: 10),
              // Luz indicadora
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primary, // Verde activo
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.6),
                      blurRadius: 6,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}