import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.openSansTextTheme(),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFE8F5E9), // Vert pastel clair pour le fond de la barre d'application
    elevation: 4,
  ),
  cardTheme: CardTheme(
    elevation: 4,
    color: const Color(0xFFFFFFFF),
    margin: const EdgeInsets.all(8.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    // Blanc pour les cartes
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF4CAF50), // Vert vif (teinte principale du logo)
    secondary: Color(0xFF8BC34A), // Vert doux pour les éléments secondaires
    surface: Color(0xFFE8F5E9),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8), // Garde les bords arrondis modernes
    ),
  ),
);
