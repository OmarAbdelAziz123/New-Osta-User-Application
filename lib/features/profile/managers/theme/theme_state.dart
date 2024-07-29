part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitialState extends ThemeState {}

class ChangeThemeState extends ThemeState {}