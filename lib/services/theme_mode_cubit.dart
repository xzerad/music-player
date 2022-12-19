import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'theme_mode_state.dart';

class ThemeModeCubit extends Cubit<ThemeModeState> {
  ThemeModeCubit() : super(const BrightMode(ThemeMode.light));

  setDarkMode()async{
    emit(const DarkMode(ThemeMode.dark));
  }

  setBrightMode() async {
    emit(const BrightMode(ThemeMode.light));
  }

}
