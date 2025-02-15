import 'package:flutter/material.dart';
import 'package:flutter_app/app/models/product.dart';
import 'package:flutter_app/app/networking/dio/interceptors/order_interceptor.dart';
import 'package:flutter_app/resources/pages/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../config/keys.dart';
import '../../resources/pages/base_navigation_hub.dart';
import '../models/coupon.dart';
import '../models/customer.dart';
import '../models/order.dart';
import '/config/decoders.dart';
import 'package:nylo_framework/nylo_framework.dart';

import 'dio/interceptors/example_interceptor.dart';

class CustomerApiService extends NyApiService {
  CustomerApiService({BuildContext? buildContext})
      : super(buildContext, decoders: modelDecoders,
            baseOptions: (BaseOptions baseOptions) {
          return baseOptions
            ..connectTimeout = Duration(seconds: 10)
            ..sendTimeout = Duration(seconds: 10)
            ..receiveTimeout = Duration(seconds: 10);
        });

  @override
  String get baseUrl => getEnv('API_BASE_URL');

  @override
  Map<Type, Interceptor> get interceptors => {
        if (getEnv('APP_DEBUG') == true)
          PrettyDioLogger: PrettyDioLogger(
            requestBody: true,
          ),
        ExampleInterceptor: ExampleInterceptor(),
      };

  /// Example API Request
  Future loginCustomer({required Map<String, dynamic> data}) async {
    return await network(
      request: (request) => request.post("/api/customer/login", data: data),
      handleSuccess: (response) async {
        if (response.statusCode == 200) {
          await Keys.bearerToken.save(response.data['access_token']);
          Fluttertoast.showToast(
              msg: "Login successful", backgroundColor: Colors.green);
          await Auth.authenticate(data: response.data['customer']);
          return 0;
        } else {
          return 1;
        }
      },
      handleFailure: (error) {
        if (error.response?.statusCode == 401) {
          Fluttertoast.showToast(
              msg: "Incorrect login details", backgroundColor: Colors.red);
        }
      },
    );
  }

  Future registerCustomer({required Map<String, dynamic> data}) async {
    return await network(
      request: (request) => request.post("/api/customer/register", data: data),
      handleSuccess: (response) async {
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: "Account created successfully",
              backgroundColor: Colors.green);
          return 0;
        } else {
          return 1;
        }
      },
    );
  }

  Future<List<Product>> getAllProducts() async {
    return await network(
      request: (request) => request.get("/api/customer/products"),
      headers: {
        "Authorization": "Bearer ${await Keys.bearerToken.read()}",
      },
      cacheKey: "products",
      cacheDuration: const Duration(hours: 1), // cache for 1 hour
      handleSuccess: (response) async {
        if (response.statusCode == 200) {
          List<dynamic> data = response.data;
          return data.map((json) => Product.fromJson(json)).toList();
        } else {
          throw Exception("Failed to load products");
        }
      },
    );
  }

// Last One Order Tracking

  Future<Order> trackOrders() async {
    return await network(
      request: (request) => request.get("/api/customer/orders"),
      headers: {
        "Authorization": "Bearer ${await Keys.bearerToken.read()}",
      },
      handleSuccess: (response) async {
        if (response.statusCode == 200) {
          // Retune Last Order from the list of orders

          List<dynamic> data = response.data;
          return Order.fromJson(data.last);
        } else {
          throw Exception("Failed to load orders");
        }
      },
      handleFailure: (error) {
        if (error.response?.statusCode == 404) {
          return null;
        }
      },
    );
  }

  Future<Customer> getProfile() async {
    return await network(
      request: (request) => request.get("/api/customer/profile"),
      headers: {
        "Authorization": "Bearer ${await Keys.bearerToken.read()}",
      },
      handleSuccess: (response) async {
        if (response.statusCode == 200) {
          return Customer.fromJson(response.data);
        } else {
          throw Exception("Failed to load profile");
        }
      },
    );
  }

  Future<List<Coupon>> getAllCoupons() async {
    return await network(
      request: (request) => request.get("/api/customer/coupons"),
      headers: {
        "Authorization": "Bearer ${await Keys.bearerToken.read()}",
      },

      handleSuccess: (response) async {
        if (response.statusCode == 200) {
          List<dynamic> data = response.data;
          return data.map((json) => Coupon.fromJson(json)).toList();

        } else {
          throw Exception("Failed to load coupons");
        }
      },
    );
  }

  Future<List<Order>> getAllOrders() async {
    return await network(
      request: (request) => request.get("/api/customer/orders"),
      headers: {
        "Authorization": "Bearer ${await Keys.bearerToken.read()}",
      },
      handleSuccess: (response) async {
        if (response.statusCode == 200) {
          List<dynamic> data = response.data;
          return data.map((json) => Order.fromJson(json)).toList();
        } else {
          throw Exception("Failed to load orders");
        }
      },
    );
  }

  Future cancelOrder({required int orderId}) async {
    return await network(
      request: (request) => request.post("/api/customer/orders/$orderId/cancel"),
      headers: {
        "Authorization": "Bearer ${await Keys.bearerToken.read()}",
      },
      handleSuccess: (response) async {
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: "Order Cancelled", backgroundColor: Colors.green);
          return 0;
        } else {
          return 1;
        }
      },
    );
  }



  Future placeOrder({required FormData data}) async {
    return await network(
      request: (request) => request.post("/api/customer/place/order", data: data),
      headers: {
        "Authorization": "Bearer ${await Keys.bearerToken.read()}",
      },
      handleSuccess: (response) async {
        if (response.statusCode == 201) {
           printDebug("Order Placed ${response.data}");
          return 0;
        } else {
          return 1;
        }
      },
    );
  }


  Future applyCoupon({required  Map<String, dynamic> data}) async {
    return await network(
      request: (request) => request.post("/api/customer/coupons/apply", data: data),
      headers: {
        "Authorization": "Bearer ${await Keys.bearerToken.read()}",
      },
      handleSuccess: (response) async {
        if (response.statusCode == 200) {
          return response.data['discount'];
        } else {
          return 1;
        }
      },
      handleFailure: (error) {
        Fluttertoast.showToast(msg: "${error.response?.data["message"]}", backgroundColor: Colors.red);

      },
    );
  }







  Future logout() async {
    return await network(
      request: (request) => request.post("/api/customer/logout"),
      headers: {
        "Authorization": "Bearer ${await Keys.bearerToken.read()}",
      },
      handleSuccess: (response) async {
        if (response.statusCode == 200) {
          await Keys.bearerToken.deleteFromStorage();
          await Auth.logout();
          return 0;
        } else {
          throw Exception("Failed to load coupons");
        }
      },
    );


  }




}
