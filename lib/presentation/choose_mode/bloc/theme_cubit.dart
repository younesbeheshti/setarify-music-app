import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void updateTheme(ThemeMode themeMode) => emit(themeMode);

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    // Parse the stored theme mode from JSON
    final themeString = json['themeMode'] as String?;
    if (themeString != null) {
      return ThemeMode.values.firstWhere(
            (mode) => mode.toString() == themeString,
        orElse: () => ThemeMode.system, // Default fallback if parsing fails
      );
    }
    return ThemeMode.system;
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    // Convert the current theme mode to a JSON-friendly format
    return {'themeMode': state.toString()};
  }
}
