import 'package:flutter/material.dart';
import 'package:flutter_app/app/models/customer.dart';
import 'package:flutter_app/bootstrap/helpers.dart';
import 'package:flutter_app/resources/widgets/safearea_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../app/networking/customer_api_service.dart';
import '../pages/coupons_page.dart';
import '../pages/login_page.dart';
import '../pages/my_orders_page.dart';
import 'full_loader_widget.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  createState() => _ProfileTabState();
}

class _ProfileTabState extends NyState<ProfileTab> {
  @override
  LoadingStyle get loadingStyle => LoadingStyle.skeletonizer();

  @override
  get init => () {
        _apiService.getProfile().then((value) {
          user = value;
          setState(() {
            user = user;
          });
        });
      };

  CustomerApiService _apiService = CustomerApiService();
  Customer? user;

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeAreaWidget(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    CircleAvatar(
                      backgroundColor: ThemeColor.get(context).primaryAccent,
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://cdn1.iconfinder.com/data/icons/facely-metapeople-3d-avatar-set/512/17._Designer.png"),
                    ),
                    SizedBox(height: 20),
                    Text("${user?.name ?? ""}")
                        .titleLarge(fontWeight: FontWeight.bold),
                    Text("${user?.studentId ?? ""}").bodyMedium(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text("Orders").bodyMedium(),
                        Text("${user?.totalOrders ?? "0"}")
                            .titleLarge(fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text("Total Due").bodyMedium(),
                        Text("৳ ${user?.totalDue ?? "0"}")
                            .titleLarge(fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text("Wallet").bodyMedium(),
                        Text("৳ 5.00").titleLarge(fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(),
              Text("Account")
                  .titleMedium(fontWeight: FontWeight.bold)
                  .paddingSymmetric(horizontal: 10),
              Text("Manage your account")
                  .bodyMedium()
                  .paddingOnly(left: 10, bottom: 10),
              ListTile(
                tileColor: Colors.grey[200],
                subtitle: Text("Check Available Coupons"),
                title: Text("Coupons"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: Icon(Icons.integration_instructions_rounded),
                onTap: () {
                  routeTo(CouponsPage.path);
                },
              ).paddingSymmetric(vertical: 5),
              ListTile(
                tileColor: Colors.grey[200],
                title: Text("My Orders"),
                subtitle: Text("View your All orders"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: Icon(Icons.list_alt),
                onTap: () {
                  routeTo(MyOrdersPage.path);
                },
              ).paddingSymmetric(vertical: 5),
              ListTile(
                tileColor: Colors.grey[200],
                title: Text("Logout").bodyMedium(color: Colors.red),
                subtitle: Text("Logout from your account"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                onTap: () {
                  LoadingDialog.show(context);
                  _apiService.logout().then((value) {
                    if (value == 0) {
                      routeTo(LoginPage.path ,navigationType: NavigationType.pushAndForgetAll);
                    }
                    LoadingDialog.hide(context);
                  });
                },
              ).paddingSymmetric(vertical: 5),
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network("https://cdn-icons-png.flaticon.com/512/25/25231.png",width: 20,height: 20),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Contribute To Our Project").bodyMedium(color: Colors.grey),
                      Text("Help us to improve our project by contributing to our project").bodySmall(color: Colors.grey),
                      TextButton(onPressed: (){}, child: Text("Source Code").bodyMedium(color: ThemeColor.get(context).primaryAccent,fontWeight: FontWeight.bold))
                    ],
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
