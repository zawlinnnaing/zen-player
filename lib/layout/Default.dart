import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';
import 'package:zen_player/modules/home/Home.dart';
import 'package:zen_player/modules/search/SearchButton.dart';
import 'package:zen_player/modules/setting/Setting.dart';
import 'package:zen_player/redux/actions/app.dart';
import 'package:zen_player/redux/states/app.dart';
import 'package:zen_player/utils/config.dart';
import 'package:zen_player/utils/routes.dart';

class _BottomNavVm {
  final int viewIdx;
  final Function(int idx) onIdxChange;
  _BottomNavVm({required this.viewIdx, required this.onIdxChange});
  factory _BottomNavVm.fromStore(Store<AppState> store) {
    return _BottomNavVm(
        viewIdx: store.state.currentViewIndex,
        onIdxChange: (idx) => store.dispatch(UpdateViewIndexAction(idx)));
  }
}

class BottomNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomNaviagtionState();
  }
}

class _BottomNaviagtionState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  List<Widget> _wigets = [HomePage(), Setting()];
  void _onItemTap(int idx, Function(int idx) idxChangeFn, BuildContext contex) {
    idxChangeFn(idx);
    Routes.changeRouteWithoutAnimation(_wigets[idx], context);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
        builder: (BuildContext context, _BottomNavVm vm) => BottomNavigationBar(
              selectedItemColor: accentColor,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(MaterialCommunityIcons.home_outline),
                    label: "Home",
                    activeIcon: Icon(Icons.home)),
                BottomNavigationBarItem(
                    activeIcon: Icon(Icons.settings),
                    icon: Icon(Icons.settings_outlined),
                    label: "Settings")
              ],
              currentIndex: vm.viewIdx,
              onTap: (idx) => _onItemTap(idx, vm.onIdxChange, context),
            ),
        converter: (Store<AppState> store) => _BottomNavVm.fromStore(store));
  }
}

class DefaultLayout extends StatelessWidget {
  final String appTitle = "Zen Player";
  final Widget child;
  final AppBar? appBar;
  final bool showBackBtn;
  DefaultLayout(
      {Key? key, required this.child, this.appBar, this.showBackBtn = false});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.appBar ??
          AppBar(
            toolbarHeight: 48,
            title: SvgPicture.asset(
              "assets/icon.svg",
              width: 32,
              height: 32,
              semanticsLabel: "Icon",
            ),
            automaticallyImplyLeading: this.showBackBtn,
            actions: [
              SearchButton(),
            ],
          ),
      body: this.child,
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
