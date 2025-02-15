import 'package:flutter/material.dart';
import 'package:flutter_app/bootstrap/helpers.dart';
import 'package:nylo_framework/nylo_framework.dart';

class OrderTrackingCard extends StatefulWidget {
  final String order_id;
  final String page_count;
  final String total_price;
  final String status;
  final String color;

  const OrderTrackingCard(
      {super.key,
      required this.page_count,
      required this.total_price,
      required this.status,
      required this.order_id,
      required this.color});

  static String state = "order_tracking_card";

  @override
  createState() => _OrderTrackingCardState();
}

class _OrderTrackingCardState extends NyState<OrderTrackingCard> {
  _OrderTrackingCardState() {
    stateName = OrderTrackingCard.state;
  }

  @override
  get init => () async {
        // 'stateData' will contain the current state data
      };

  @override
  stateUpdated(dynamic data) async {
    // e.g. to update this state from another class
    // updateState(OrderTrackingCard.state, data: "example payload");
  }

  @override
  Widget view(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          Text(
            "Order ID: #A478A${widget.order_id}",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          Text(
            "Preparing your order",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 5),
          Text(
            "Arrives in Next Class Room",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.purple),
          ),

          SizedBox(height: 10),

          // Progress Indicator with Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.cancel_sharp,
                  color: widget.status == "Decline" ||
                      widget.status == "Delivered"
                      ? Colors.red
                      : Colors.grey),
              Container(height: 3, width: 30, color: Colors.grey),
              Icon(Icons.pending,
                  color: widget.status == "Pending" ||
                          widget.status == "Accepted" ||
                          widget.status == "Printed" ||
                          widget.status == "Completed" ||
                          widget.status == "Ready for Delivery"
                      ? Colors.green
                      : Colors.grey),
              Container(height: 3, width: 30, color: Colors.grey),
              Icon(Icons.check_box,
                  color: widget.status == "Accepted" ||
                          widget.status == "Printed" ||
                          widget.status == "Ready for Delivery"
                      ? Colors.green
                      : Colors.grey),
              Container(height: 3, width: 30, color: Colors.grey),
              Icon(Icons.print,
                  color: widget.status == "Printed" ||
                          widget.status == "Ready for Delivery"
                      ? Colors.green
                      : Colors.grey),
              Container(height: 3, width: 30, color: Colors.grey),
              Icon(Icons.file_copy,
                  color: widget.status == "Ready for Delivery" ||
                          widget.status == "Delivered"
                      ? Colors.green
                      : Colors.grey),


            ],
          ),

          SizedBox(height: 10),

          // Order Info
          Text(
            "Chuck’s Donut Inc is preparing your order.",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),

          SizedBox(height: 15),

          // Forgot Something Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payable Amount :৳ ${widget.total_price}",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Total Page ${widget.page_count} With ${widget.color} Print Please Check Your Order",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ).paddingOnly(bottom: 20, top: 10, left: 5, right: 5);
  }
}
