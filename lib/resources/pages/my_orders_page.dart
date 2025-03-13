import 'package:flutter/material.dart';
import 'package:flutter_app/app/models/order.dart';
import 'package:flutter_app/resources/widgets/safearea_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../app/networking/customer_api_service.dart';
import '../widgets/full_loader_widget.dart';
import '../widgets/order_card_widget.dart';

class MyOrdersPage extends NyStatefulWidget {
  static RouteView path = ("/my-orders", (_) => MyOrdersPage());

  MyOrdersPage({super.key}) : super(child: () => _MyOrdersPageState());
}

class _MyOrdersPageState extends NyPage<MyOrdersPage> {
  @override
  get init => () {
        setLoading(true);
        _apiService.getAllOrders().then((value) {
          orders = value;
          setLoading(false);
          setState(() {
            orders = orders;
          });
        });
      };

  CustomerApiService _apiService = CustomerApiService();
  List<Order> orders = [];

  String getFormattedDate(String date) {
    // Convert date to local time and remove the time
    DateTime dateTime = DateTime.parse(date).toLocal();
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  @override
  LoadingStyle get loadingStyle => LoadingStyle.skeletonizer();


  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Orders")),
      body: SafeAreaWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("My Orders").titleLarge(),
            Text("Your All Time Orders Can View").bodySmall(),
            if (orders.isEmpty)
              Center(
                child: Text("No orders found"),
              ).paddingOnly(top: 50)
            else
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return OrderCard(
                    order_id: "${orders.reversed.toList()[index].id}",
                    page_count: "${orders.reversed.toList()[index].pageCount}",
                    total_price:
                        "${orders.reversed.toList()[index].totalPrice}",
                    status: "${orders.reversed.toList()[index].status}",
                    order_date: getFormattedDate(
                        "${orders.reversed.toList()[index].createdAt}"),
                    color: "${orders.reversed.toList()[index].color}",
                    cancelOrder: () {
                      LoadingDialog.show(context);
                      _apiService
                          .cancelOrder(
                              orderId: orders.reversed.toList()[index].id!)
                          .then((value)  {
                        if (value == 0) {
                          orders.removeAt(orders.length - 1 - index);
                          setState(() {
                            orders = orders;
                          });
                        }
                        LoadingDialog.hide(context);
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 0);
                },
                itemCount: orders.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
