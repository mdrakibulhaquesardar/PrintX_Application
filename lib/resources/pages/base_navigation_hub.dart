import 'package:flutter/material.dart';
import 'package:flutter_app/resources/widgets/file_order_tab_widget.dart';
import 'package:flutter_app/resources/widgets/home_tab_widget.dart';
import 'package:flutter_app/resources/widgets/profile_tab_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

class BaseNavigationHub extends NyStatefulWidget with BottomNavPageControls {
  static RouteView path = ("/base", (_) => BaseNavigationHub());

  
  BaseNavigationHub()
      : super(
            child: () => _BaseNavigationHubState(),
            stateName: path.stateName());

  /// State actions
  static NavigationHubStateActions stateActions = NavigationHubStateActions(path.stateName());
}

class _BaseNavigationHubState extends NavigationHub<BaseNavigationHub> {

  /// Layouts: 
  /// - [NavigationHubLayout.bottomNav] Bottom navigation
  /// - [NavigationHubLayout.topNav] Top navigation
  NavigationHubLayout? layout = NavigationHubLayout.bottomNav(
    // backgroundColor: Colors.white,
  );

  /// Should the state be maintained
  @override
  bool get maintainState => true;

  /// Navigation pages
  _BaseNavigationHubState() : super(() async {
    return {
      0: NavigationTab(
        title: "Home",
         page: HomeTab(), // create using: 'dart run nylo_framework:main make:stateful_widget home_tab'
        icon: Icon(Icons.home),
        activeIcon: Icon(Icons.home),
      ),

      1: NavigationTab(
         title: "Place Order",
          page: FileOrderTab(), // create using: 'dart run nylo_framework:main make:stateful_widget profile_tab'
         icon: Icon(Icons.file_copy),
         activeIcon: Icon(Icons.cloud_upload),

      ),


      2: NavigationTab(
         title: "Profile",
          page: ProfileTab(), // create using: 'dart run nylo_framework:main make:stateful_widget settings_tab'
         icon: Icon(Icons.person_2_rounded),
         activeIcon: Icon(Icons.person_2_rounded),
      ),
    };
  });

  /// Handle the tap event
  @override
  onTap(int index) {
    super.onTap(index);
  }
}
