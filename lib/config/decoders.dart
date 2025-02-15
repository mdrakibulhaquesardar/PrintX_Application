import '/app/models/coupon.dart';
import '/app/controllers/profile_controller.dart';
import '/app/models/order.dart';
import '/app/models/product.dart';

import '/app/networking/customer_api_service.dart';
import '/app/models/customer.dart';
import '/app/controllers/home_controller.dart';
import '/app/models/user.dart';
import '/app/networking/api_service.dart';

/* Model Decoders
|--------------------------------------------------------------------------
| Model decoders are used in 'app/networking/' for morphing json payloads
| into Models.
|
| Learn more https://nylo.dev/docs/6.x/decoders#model-decoders
|-------------------------------------------------------------------------- */

final Map<Type, dynamic> modelDecoders = {
  Map<String, dynamic>: (data) => Map<String, dynamic>.from(data),

  List<User>: (data) =>
      List.from(data).map((json) => User.fromJson(json)).toList(),
  //
  User: (data) => User.fromJson(data),

  // User: (data) => User.fromJson(data),

  List<Customer>: (data) => List.from(data).map((json) => Customer.fromJson(json)).toList(),

  Customer: (data) => Customer.fromJson(data),

  List<Product>: (data) => List.from(data).map((json) => Product.fromJson(json)).toList(),

  Product: (data) => Product.fromJson(data),

  List<Order>: (data) => List.from(data).map((json) => Order.fromJson(json)).toList(),

  Order: (data) => Order.fromJson(data),

  List<Coupon>: (data) => List.from(data).map((json) => Coupon.fromJson(json)).toList(),

  Coupon: (data) => Coupon.fromJson(data),
};

/* API Decoders
| -------------------------------------------------------------------------
| API decoders are used when you need to access an API service using the
| 'api' helper. E.g. api<MyApiService>((request) => request.fetchData());
|
| Learn more https://nylo.dev/docs/6.x/decoders#api-decoders
|-------------------------------------------------------------------------- */

final Map<Type, dynamic> apiDecoders = {
  ApiService: () => ApiService(),

  // ...

  CustomerApiService: CustomerApiService(),
};

/* Controller Decoders
| -------------------------------------------------------------------------
| Controller are used in pages.
|
| Learn more https://nylo.dev/docs/6.x/controllers
|-------------------------------------------------------------------------- */
final Map<Type, dynamic> controllers = {
  HomeController: () => HomeController(),

  // ...

  ProfileController: () => ProfileController(),
};
