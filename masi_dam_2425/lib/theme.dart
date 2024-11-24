import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.openSansTextTheme(),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFDFF5E1), // Vert pastel clair pour le fond de la barre d'application
    elevation: 4,
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF4CAF50), // Vert vif (teinte principale du logo)
    secondary: Color(0xFF8BC34A), // Vert doux pour les éléments secondaires
    surface: Color(0xFFDFF5E1), // Fond principal en vert pastel clair
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8), // Garde les bords arrondis modernes
    ),
  ),
);
