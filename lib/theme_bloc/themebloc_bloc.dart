import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:multi_theme_with_appainter/theme_type.dart';

import 'bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeType> {
  ThemeBloc() : super(ThemeType.light) {
    on<ToggleThemeEvent>(_toggleTheme);
  }

  void _toggleTheme(ToggleThemeEvent event, Emitter<ThemeType> state) {
    if (event.type == ThemeType.dark) {
      return emit(ThemeType.dark);
    }
    if (event.type == ThemeType.light) {
      return emit(ThemeType.light);
    }
    return emit(ThemeType.light);
  }
}
