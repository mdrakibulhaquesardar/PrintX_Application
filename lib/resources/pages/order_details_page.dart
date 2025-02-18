import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bootstrap/helpers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../app/networking/customer_api_service.dart';
import '../widgets/buttons/buttons.dart';
import '../widgets/full_loader_widget.dart';
import '../widgets/home_tab_widget.dart';
import 'my_orders_page.dart';

class OrderDetailsPage extends NyStatefulWidget {

  static RouteView path = ("/order-details", (_) => OrderDetailsPage());

  OrderDetailsPage({super.key}) : super(child: () => _OrderDetailsPageState());
}

class _OrderDetailsPageState extends NyPage<OrderDetailsPage> {

  @override
  get init => () async {

    await _calculateTotalPrice();
    printDebug(widget.data());

  };

  double totalPages = 0;
  double total_price = 0;
  double delivery_charge = 0;
  double sub_total = 0;
  double price_per_page = 4;
  bool isCouponApplied = false;

  Future  _calculateTotalPrice() async {

      totalPages = double.parse(widget.data()["totalPages"].toString());
      total_price =  totalPages*price_per_page;
      delivery_charge = 0;
      sub_total = total_price + delivery_charge;

  }
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  CustomerApiService _customerApiService = CustomerApiService();


  Future _placeOrder() async {
    printDebug("Calling Place Order ${_textEditingController.text}");
    FormData data = FormData.fromMap({
      "pdf_file": await MultipartFile.fromFile(widget.data()["file"].path),
      "total_pages": widget.data()["totalPages"],
      "total_price": sub_total,
      "delivery_charge": delivery_charge,
      if(isCouponApplied) "coupon_code": _textEditingController.text,
      "color": "Color",
      'note': _noteController.text
    });

    LoadingDialog.show(context);
    _customerApiService.placeOrder(data: data).then((value) {
      if (value == 0) {
        LoadingDialog.hide(context);
        Fluttertoast.showToast(msg: "Order Placed", backgroundColor: Colors.green);
        routeTo(MyOrdersPage.path,navigationType: NavigationType.pushReplace);
      } else {
        LoadingDialog.hide(context);
        Fluttertoast.showToast(msg: "Failed to place order", backgroundColor: Colors.red);
      }
    });

  }



  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details")
      ),
      body: SafeArea(
         child: SingleChildScrollView(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text("Checkout Order").titleLarge(
                  color: Theme.of(context).primaryColor
                ),
                Text("Order ID: Axd477c").bodySmall(),
                   Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Order Summary").titleMedium(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    Icon(Icons.receipt_long, color: ThemeColor.get(context).primaryAccent),
                  ],
                ),
                Divider(thickness: 1),
                SizedBox(height: 5),
                Text(
                  widget.data()["fileName"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ThemeColor.get(context).primaryAccent,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Pages: ${widget.data()["totalPages"]}",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    Text(
                      "1 Copy",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Color Format",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    Spacer(),
                    Text(
                      "Colorized",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                )
           
              ],
            ),
                   ),
                SizedBox(height: 10),
                 //Coupon Code
                if(!isCouponApplied)
                 Row(
                 children: [
                   Expanded(
                     flex: 5,
                     child: NyTextField.compact(
                       readOnly: isCouponApplied,
                       controller: _textEditingController,
                       hintText: "Enter Coupon Code",
                       prefixIcon: Icon(Icons.card_giftcard),
                     ),
                   ),
                    SizedBox(width: 10),
                   Expanded(
                     flex: 1,
                       child: Button.primary(
                         width: double.infinity,
                         height: 30,
                         text: "Apply",
                         onPressed: () {
                            // Apply Coupon
                           LoadingDialog.show(context);
                           _customerApiService.applyCoupon(
                             data: {
                               "code": _textEditingController.text,
                                "total_price": total_price

                             }
                           ).then((value) {
                             if(value != null) {
                                LoadingDialog.hide(context);
                                Fluttertoast.showToast(msg: "Coupon Applied", backgroundColor: Colors.green);
                                setState(() {
                                  sub_total = sub_total - double.parse(value.toString());
                                  isCouponApplied = true;
                                });

                             } else {
                               LoadingDialog.hide(context);

                             }
                           });
                         },
                       )
                    ),
                 ],
               ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(5),
           
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Amount Details").titleMedium(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          Icon(Icons.opacity_rounded, color: ThemeColor.get(context).primaryAccent),
                        ],
                      ),
                      Divider(thickness: 1),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text("Total Amount", ).bodyMedium(
                            color: Colors.black87,
                          ),
                          Spacer(),
                          Text("৳ ${total_price}", ).bodyMedium(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text("Delivery Charge", ).bodyMedium(
                            color: Colors.black87,
                          ),
                          Spacer(),
                          Text("৳ ${delivery_charge}", ).bodyMedium(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                       if(isCouponApplied)
                       Row(
                        children: [
                          Text("Coupon Discount").bodyMedium(
                            color: Colors.black87,
                          ),
                          Spacer(),
                          Text("- ৳ ${isCouponApplied ? total_price - sub_total : 0}",).bodyMedium(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                       ),


                      //Dotted Line
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[300],
                        margin: EdgeInsets.symmetric(vertical: 10),
                      ),
                      Row(
                        children: [
                          Text("SubTotal",).bodyMedium(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                          Spacer(),
                          Text("৳ ${sub_total}",).bodyMedium(
                            color: ThemeColor.get(context).primaryAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                 NyTextField.compact(
                 controller: _noteController,
                 hintText: "Add Note (Optional)",
                 maxLines: 3,
                   hintStyle: TextStyle(color: Colors.grey),
               ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                Button.primary(
                  text: "Place Order",
                  onPressed: (){
                    _placeOrder();
                  },
                ),



           
           
           
           
           
           
                   ],
           ).paddingSymmetric(horizontal: 10, vertical: 10),
         ),
      ),
    );
  }
}
