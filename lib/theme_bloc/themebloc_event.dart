import 'package:equatable/equatable.dart';

import '../theme_type.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ToggleThemeEvent extends ThemeEvent{
  final ThemeType type;

  const ToggleThemeEvent(this.type);

  @override
  // TODO: implement props
  List<Object?> get props => [type];
}
