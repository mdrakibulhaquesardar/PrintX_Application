import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ProfilePage extends NyStatefulWidget {

  static RouteView path = ("/profile", (_) => ProfilePage());
  
  ProfilePage({super.key}) : super(child: () => _ProfilePageState());
}

class _ProfilePageState extends NyPage<ProfilePage> {

  @override
  get init => () {

  };

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile")
      ),
      body: SafeArea(
         child: Column(
           children: [
             Text("Profile Page")
           ]
         )
      ),
    );
  }
}
