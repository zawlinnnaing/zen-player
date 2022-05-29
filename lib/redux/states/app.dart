import 'package:zen_player/redux/states/theme.dart';

class AppState {
  int currentViewIndex = 0;
  ThemeState? themeState;
  Set<String> searchHistory = Set();
  AppState() {
    themeState = ThemeState();
  }
}
