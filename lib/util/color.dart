import 'package:flutter/material.dart';

ColorScheme lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.blue, // номер телефона
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFD3E1EC), //сворачивание и выход
    onPrimaryContainer: Color(0xFF1D3140), // Blue-grey on container
    secondary: Color(0xFF757575), // Neutral grey
    onSecondary: Colors.white,
    secondaryContainer: Color.fromARGB(
        255, 22, 163, 34), // кнопка регистарция и публикация заказа
    onSecondaryContainer:
        Color.fromARGB(255, 255, 255, 255), //   цвет текста внутри кнопки
    error: Color(0xFFB00020), // Error
    onError: Colors.white,
    errorContainer: Color(0xFFF8D7DA), // Error red container
    onErrorContainer: Color(0xFF410002), // Error red on container
    background: Color.fromARGB(255, 255, 255, 255), // Background grey
    onBackground: Color(0xFF1C1B1F), // Background text color
    surface: Color.fromARGB(255, 59, 116, 43), // апп бар
    onSurface: Color(0xFF1C1B1F), // Surface text color
    surfaceVariant: Color.fromARGB(255, 240, 242,
        227), //  цвет инактивного заказа и иконки апп бара и qrкода
    onSurfaceVariant: Color.fromARGB(255, 0, 0, 0), //цвет иконок
    tertiaryContainer: Color.fromARGB(255, 205, 212, 201) //активный заказ
    );

ColorScheme darkColorScheme = const ColorScheme(
  brightness: Brightness.dark,

  primary: Color(0xFF9C27B0), // Purple
  onPrimary: Color(0xFFFFFFFF), // White text
  primaryContainer: Color(0xFFE040FB), // Lightened Purple container
  onPrimaryContainer: Color(0xFFFFFFFF), // White text
  secondary: Color.fromARGB(255, 173, 131, 5), // Amber
  onSecondary: Color(0xFFFFFFFF), // White text
  secondaryContainer: Color(0xFFFFA000), // Lightened Amber container
  onSecondaryContainer: Color(0xFFFFFFFF), // White text
  error: Color(0xFFFF5252), // Error red
  onError: Color(0xFFFFFFFF), // White text
  errorContainer: Color(0xFFFF0000), // Error red container
  onErrorContainer: Color(0xFFFFFFFF), // White text
  background: Color(0xFF121212), // Dark grey
  onBackground: Color(0xFFFFFFFF), // White text
  surface: Color(0xFF9C27B0), // Dark grey
  onSurface: Color(0xFFFFFFFF), // White text
  surfaceVariant: Color.fromARGB(255, 30, 30, 30), // Darker grey
  onSurfaceVariant: Color.fromARGB(255, 255, 255, 255), // White text
  tertiaryContainer: Color.fromARGB(255, 52, 38, 54),
);
