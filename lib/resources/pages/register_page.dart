import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../app/forms/register_form.dart';
import '../../app/networking/customer_api_service.dart';
import '../widgets/buttons/buttons.dart';
import '../widgets/full_loader_widget.dart';
import '../widgets/loader_widget.dart';
import '../widgets/logo_widget.dart';
import 'login_page.dart';

class RegisterPage extends NyStatefulWidget {
  static RouteView path = ("/register", (_) => RegisterPage());

  RegisterPage({super.key}) : super(child: () => _RegisterPageState());
}

class _RegisterPageState extends NyPage<RegisterPage> {
  @override
  get init => () {};



  @override
  LoadingStyle get loadingStyle => LoadingStyle.skeletonizer();

  RegisterForm form = RegisterForm();
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
                    "https://static.vecteezy.com/system/resources/previews/016/716/631/non_2x/flat-isometric-3d-illustration-concept-of-creating-personal-data-for-registration-free-vector.jpg",
                    fit: BoxFit.cover,
                  ),
                  Row(
                    children: [
                      Text("Register")
                          .displaySmall(fontWeight: FontWeight.bold)
                          .paddingOnly(top: 20),
                      Logo(
                        width: 30,
                        height: 30,
                      ).paddingOnly(right: 10, top: 20),
                    ],
                  ),
                  Text("Enter your registration details below").titleMedium(),
                  SizedBox(height: 20),
                  NyForm(
                    form: form,
                    footer: Button.primary(
                      text: "Register",
                      onPressed: () {
                        form.submit(
                          onSuccess: (data) async {
                            printDebug(data);
                           // await setLoading(true);
                            LoadingDialog.show(context);
                            _apiService.registerCustomer(data: data).then( (value) {
                              LoadingDialog.hide(context);
                              if(value == 0) {
                                routeTo(LoginPage.path);
                              }
                              else {
                                Fluttertoast.showToast(msg: "An error occurred", backgroundColor: Colors.red);
                              }
                            }).catchError((error) {
                              LoadingDialog.hide(context);
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ).paddingOnly(left: 20, right: 20),
        ),
      ),
    );
  }
}