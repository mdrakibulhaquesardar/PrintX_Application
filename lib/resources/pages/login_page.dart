import 'package:flutter/material.dart';
import 'package:flutter_app/app/forms/login_form.dart';
import 'package:flutter_app/app/networking/api_service.dart';
import 'package:flutter_app/bootstrap/helpers.dart';
import 'package:flutter_app/resources/pages/register_page.dart';
import 'package:flutter_app/resources/widgets/buttons/buttons.dart';
import 'package:flutter_app/resources/widgets/full_loader_widget.dart';
import 'package:flutter_app/resources/widgets/logo_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../app/networking/customer_api_service.dart';
import 'base_navigation_hub.dart';

class LoginPage extends NyStatefulWidget {
  static RouteView path = ("/login", (_) => LoginPage());

  LoginPage({super.key}) : super(child: () => _LoginPageState());
}

class _LoginPageState extends NyPage<LoginPage> {
  @override
  get init => () async {

  };

  @override
  LoadingStyle get loadingStyle => LoadingStyle.skeletonizer();

  LoginForm form = LoginForm();
  CustomerApiService _apiService = CustomerApiService();

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://img.freepik.com/free-photo/computer-security-with-login-password-padlock_107791-16191.jpg",
                    fit: BoxFit.cover,
                  ),
                  Row(
                    children: [

                      Text("Login").displaySmall(fontWeight: FontWeight.bold,color: ThemeColor.get(context).content).paddingOnly(top: 20),
                      Logo(width: 30,height: 30,).paddingOnly(right: 10, top: 20),
                    ],
                  ),
                  Text("Enter your login details below").titleMedium(),
                  SizedBox(height: 20),
                  NyForm(
                    form: form,
                    footer: Button.primary(
                      text: "Login",
                      onPressed: () {
                        form.submit(
                          onSuccess: (data) {
                            LoadingDialog.show(context);
                            _apiService.loginCustomer(data: data).then((customer) async {
                              LoadingDialog.hide(context);
                              if(customer == 0) {
                                routeTo(BaseNavigationHub.path ,navigationType: NavigationType.pushAndForgetAll);
                              }
                              else {
                                LoadingDialog.hide(context);
                              }
                            });
                          },
                          onFailure: (errors) {
                            print(errors);
                          },
                        );
                      },
                    ),
                  ),
                  // Sinup Button
                  Text("Don't have an account?").titleSmall().paddingOnly(top: 20, bottom: 10),
                  Button.secondary(
                    text: "Sign Up",
                    onPressed: () {
                      routeTo(RegisterPage.path);
                    },
                  ),
                ],
              ).paddingOnly(top: 0, left: 20, right: 20),
            ),
          ),
        ),
      ),
    );
  }
}