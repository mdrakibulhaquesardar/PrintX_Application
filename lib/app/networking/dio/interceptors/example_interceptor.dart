import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/base_navigation_hub.dart';
import 'package:flutter_app/resources/widgets/loader_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../../../resources/widgets/full_loader_widget.dart';

class ExampleInterceptor extends Interceptor {
  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if(err.response?.statusCode == 401) {
      Fluttertoast.showToast(msg: "Incorrect login details", backgroundColor: Colors.red);
    }
    if(err.response?.statusCode == 422) {
      Fluttertoast.showToast(msg: "Unprocessable Content", backgroundColor: Colors.red);
    }
    if(err.response?.statusCode == 404) {

    }

    if(err.response?.statusCode == 500) {
      Fluttertoast.showToast(msg: "Server Error", backgroundColor: Colors.red);
    }
    if(err.response?.statusCode == 400) {
    }
    else {
      Fluttertoast.showToast(msg: "Connection Timeout", backgroundColor: Colors.red);
    }




    handler.next(err);
  }


  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    handler.next(options);
  }
}
