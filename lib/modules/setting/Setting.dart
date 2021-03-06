import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:redux/redux.dart';
import 'package:zen_player/layout/Default.dart';
import 'package:zen_player/redux/actions/theme.dart';
import 'package:zen_player/redux/states/app.dart';
import 'package:zen_player/redux/states/theme.dart';
import 'package:zen_player/utils/config.dart';

class _Vm {
  ThemeState themeState = ThemeState();
  Function(bool isDarkMode) onThemeModeChange;
  _Vm({required this.themeState, required this.onThemeModeChange});
  factory _Vm.fromStore(Store<AppState> store) {
    return _Vm(
        themeState: store.state.themeState!,
        onThemeModeChange: (bool isDarkMode) {
          store.dispatch(UpdateThemeModeAction(
              themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light));
        });
  }
}

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
        builder: (BuildContext context, _Vm vm) {
          return DefaultLayout(
              child: Container(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Text("Theme mode")),
                    FlutterSwitch(
                        activeIcon: Icon(
                          MaterialCommunityIcons.weather_night,
                          color: Colors.black54,
                        ),
                        activeColor: accentColor,
                        activeText: "Dark",
                        inactiveText: "Light",
                        inactiveIcon: Icon(Entypo.light_up),
                        width: 64,
                        height: 32,
                        value: vm.themeState.mode == ThemeMode.dark,
                        onToggle: vm.onThemeModeChange)
                  ],
                )
              ],
            ),
          ));
        },
        converter: (Store<AppState> store) => _Vm.fromStore(store));
  }
}
