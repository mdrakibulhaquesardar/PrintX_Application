import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../networking/customer_api_service.dart';
import 'controller.dart';

class HomeController extends Controller {


  CustomerApiService _apiService = CustomerApiService();
  List<Product> products = [];
  Order? order;


  @override
  construct(BuildContext context) {
    super.construct(context);

  }


  void getAllProducts() async {
    _apiService.getAllProducts().then((value) {
      products = value;
      printDebug("Products: $products");
    } );
  }

  void trackOrders() async {
    _apiService.trackOrders().then((value) {
      order = value;
      printDebug("Order: $order");
    });
  }





}
