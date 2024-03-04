part of 'theme_mode_bloc.dart';

@immutable
sealed class ThemeModeEvent extends Equatable {
  const ThemeModeEvent();

  @override
  List<Object?> get props => [];
}

final class ThemeModeInitialized extends ThemeModeEvent {
  const ThemeModeInitialized();
}

final class ThemeModeChanged extends ThemeModeEvent {
  const ThemeModeChanged({required this.themeMode});

  final ThemeMode themeMode;

  @override
  List<Object?> get props => [themeMode];
}
