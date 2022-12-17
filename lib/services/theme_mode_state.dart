part of 'theme_mode_cubit.dart';

@immutable
abstract class ThemeModeState {
  final ThemeMode mode;
  const ThemeModeState(this.mode);
}

class DarkMode extends ThemeModeState {

  const DarkMode(super.mode);
}
class BrightMode extends ThemeModeState {
  const BrightMode(super.mose);
}