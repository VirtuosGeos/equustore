import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

class TechInputField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? controller;

  const TechInputField({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.controller,
  });

  @override
  State<TechInputField> createState() => _TechInputFieldState();
}

class _TechInputFieldState extends State<TechInputField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    // PROTECCIÓN 1: Verificar que el widget siga vivo antes de redibujar
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LABEL
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: GoogleFonts.jetBrainsMono(
            color: _isFocused ? AppTheme.primary : Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
          child: Text(widget.label.toUpperCase()),
        ),
        
        const SizedBox(height: 8),

        // INPUT CONTAINER
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutExpo,
          // PROTECCIÓN 2: Recortar contenido sobrante (Vital para evitar crashes con Blur)
          clipBehavior: Clip.hardEdge, 
          decoration: BoxDecoration(
            color: _isFocused 
                ? AppTheme.primary.withOpacity(0.05) 
                : Colors.white.withOpacity(0.02),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: _isFocused ? AppTheme.primary.withOpacity(0.3) : Colors.white10,
            ),
          ),
          child: Stack(
            children: [
              // CAMPO DE TEXTO
              TextFormField(
                controller: widget.controller,
                focusNode: _focusNode,
                obscureText: widget.isPassword,
                style: GoogleFonts.rajdhani(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
                cursorColor: AppTheme.primary,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  isDense: true,
                  prefixIcon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      widget.icon,
                      key: ValueKey(_isFocused),
                      size: 18,
                      color: _isFocused ? AppTheme.primary : Colors.white24,
                    ),
                  ),
                ),
              ),

              // BARRA DE ENERGÍA (Power Line)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 2, // Altura fija de la línea
                child: LayoutBuilder(
                  // PROTECCIÓN 3: Calcular el ancho real disponible dinámicamente
                  builder: (context, constraints) {
                    return Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutBack,
                        height: 2,
                        // Si está enfocado, usa el ancho máximo del padre. Si no, 0.
                        width: _isFocused ? constraints.maxWidth : 0, 
                        color: AppTheme.primary,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primary.withOpacity(0.8),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}