import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

part 'theme_state.dart';

class ThemingCubit extends Cubit<ThemeState> {
  ThemingCubit() : super(ThemeInitialState());

  static ThemingCubit get(context) => BlocProvider.of(context);

  ThemeData _themeData = ThemeData.light();

  ThemeData get themeData => _themeData;

  set themeData(ThemeData theData) {
    _themeData = theData;
    emit(ChangeThemeState());
  }

  void toggleTheme() {
    if(_themeData == ThemeData.light()) {
      themeData = ThemeData.dark();
    } else {
      themeData = ThemeData.light();
    }
  }
}
