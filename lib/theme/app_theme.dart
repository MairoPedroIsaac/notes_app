import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors - Red and Black Theme
  static const Color primaryColor = Color(0xFFD32F2F); // Dark Red
  static const Color primaryDark = Color(0xFFB71C1C); // Darker Red
  static const Color primaryLight = Color(0xFFFFCDD2); // Light Red
  static const Color secondaryColor = Color(0xFF212121); // Dark Gray/Black
  static const Color backgroundColor = Color(0xFF121212); // Dark Background
  static const Color surfaceColor = Color(0xFF1E1E1E); // Slightly Lighter Dark
  static const Color errorColor = Color(0xFFCF6679); // Soft Red
  static const Color successColor = Color(0xFF81C784); // Soft Green
  static const Color onPrimaryColor = Colors.white;
  static const Color onSecondaryColor = Colors.white;
  static const Color onBackgroundColor = Colors.white;
  static const Color onSurfaceColor = Colors.white70;
  static const Color onErrorColor = Colors.black87;

  // Text Styles
  static final TextStyle displayLarge = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: onBackgroundColor,
  );
  
  static final TextStyle displayMedium = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: onBackgroundColor,
  );

  static final TextStyle bodyLarge = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: onBackgroundColor,
  );

  static final TextStyle bodyMedium = GoogleFonts.roboto(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: onBackgroundColor,
  );

  static final TextStyle bodySmall = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: onBackgroundColor.withOpacity(0.7),
  );

  static final TextStyle labelLarge = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: onPrimaryColor,
    letterSpacing: 0.5,
  );

  // Spacing
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;

  // Elevation
  static const double elevationCard = 2.0;
  static const double elevationFab = 6.0;
  static const double elevationDialog = 8.0;
  static const double elevationAppBar = 4.0;

  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        primaryContainer: primaryDark,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
        onPrimary: onPrimaryColor,
        onSecondary: onSecondaryColor,
        onSurface: onSurfaceColor,
        onError: onErrorColor,
        background: backgroundColor,
        onBackground: onBackgroundColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      canvasColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: displayLarge.copyWith(
          color: onPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: onPrimaryColor),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        elevation: elevationFab,
      ),
      // Card theme is handled by Theme.of(context).cardTheme
      // Dialog theme is handled by Theme.of(context).dialogTheme
      textTheme: TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: onPrimaryColor,
          elevation: 2,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingMedium,
            vertical: spacingSmall,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingMedium,
            vertical: spacingSmall,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: BorderSide(color: primaryColor),
          padding: const EdgeInsets.symmetric(
            horizontal: spacingMedium,
            vertical: spacingSmall,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: primaryColor, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: errorColor, width: 2.0),
        ),
        contentPadding: const EdgeInsets.all(spacingMedium),
      ),
    );
  }
}

// Extension for easy access to theme values
extension ThemeExtension on BuildContext {
  // Colors
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get primaryDark => Theme.of(this).colorScheme.primaryContainer;
  Color get primaryLight => AppTheme.primaryLight;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get surfaceColor => Theme.of(this).colorScheme.surface;
  Color get errorColor => Theme.of(this).colorScheme.error;
  Color get successColor => AppTheme.successColor;
  
  // Text Styles
  TextStyle get displayLarge => Theme.of(this).textTheme.displayLarge!;
  TextStyle get displayMedium => Theme.of(this).textTheme.displayMedium!;
  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!;
  TextStyle get labelLarge => Theme.of(this).textTheme.labelLarge!;
  
  // Spacing
  double get smallSpacing => AppTheme.spacingSmall;
  double get mediumSpacing => AppTheme.spacingMedium;
  double get largeSpacing => AppTheme.spacingLarge;
  double get xLargeSpacing => AppTheme.spacingXLarge;
  
  // Elevation
  double get cardElevation => AppTheme.elevationCard;
  double get fabElevation => AppTheme.elevationFab;
  double get dialogElevation => AppTheme.elevationDialog;
  double get appBarElevation => AppTheme.elevationAppBar;
}
