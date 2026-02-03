import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- PALETA VELYTH TECH (VERDE) ---
  // Fondo negro profundo con un matiz muy sutil de verde oscuro
  static const Color background = Color(0xFF0F1110); 
  // Superficies (tarjetas) un poco más claras, tipo metal oscuro
  static const Color surface = Color(0xFF1A1E1C);    
  // El color principal de tu marca: Verde Eléctrico Tecnológico
  static const Color primary = Color(0xFF00D97E);    
  // Color de acento para detalles secundarios: Verde Bosque Profundo
  static const Color accent = Color(0xFF00A862);     
  
  // Textos
  static const Color textHigh = Color(0xFFEEEEEE); // Casi blanco para leer bien
  static const Color textMed = Color(0xFFB0BEC5);  // Gris claro para subtítulos

  static ThemeData get velythTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      // Definimos el esquema de colores general para que los widgets de Flutter lo entiendan
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: accent,
        surface: surface,
        background: background,
      ),
      
      // Configuración de Tipografía (Se mantiene la estética técnica)
      textTheme: TextTheme(
        displayLarge: GoogleFonts.rajdhani(
          fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: textHigh),
        displayMedium: GoogleFonts.rajdhani(
          fontSize: 32, fontWeight: FontWeight.w600, letterSpacing: 1.0, color: textHigh),
        bodyLarge: GoogleFonts.inter(fontSize: 16, color: textMed),
        bodyMedium: GoogleFonts.inter(fontSize: 14, color: textMed),
        // Usamos getFont por si el método estático falla en tu IDE
        labelLarge: GoogleFonts.getFont( 
          'JetBrains Mono',
          fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: primary),
      ),

      // Inputs estilo "Consola" (Ahora con bordes y cursores verdes)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface.withOpacity(0.8), // Un poco más sólido
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: primary.withOpacity(0.2)), // Borde sutil verde
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: primary.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: primary, width: 2), // Borde verde brillante al enfocar
        ),
        labelStyle: TextStyle(color: textMed),
        floatingLabelStyle: const TextStyle(color: primary), // El texto flota en verde
        prefixIconColor: primary.withOpacity(0.8),
        suffixIconColor: primary.withOpacity(0.8),
      ),
      
      // Color del cursor en los inputs
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primary,
        selectionColor: primary.withOpacity(0.3),
        selectionHandleColor: primary,
      ),

      // Estilo de Botones (Sólidos verdes)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.black, // Texto negro sobre verde para máximo contraste
          elevation: 8,
          shadowColor: primary.withOpacity(0.5), // Sombra verde brillante
          padding: const EdgeInsets.symmetric(vertical: 22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2), // Bordes técnicos rectos
          ),
          textStyle: GoogleFonts.rajdhani(
            fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2.0),
        ),
      ),
    );
  }
}