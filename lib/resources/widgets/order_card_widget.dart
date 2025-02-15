import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class OrderCard extends StatefulWidget {

  final String order_id;
  final String page_count;
  final String total_price;
  final String status;
  final String order_date;
  final String color;
  final Function cancelOrder;

  
  const OrderCard({super.key, required this.order_id, required this.page_count, required this.total_price, required this.status, required this.order_date, required this.color, required this.cancelOrder});
  
  static String state = "order_card";

  @override
  createState() => _OrderCardState();
}

class _OrderCardState extends NyState<OrderCard> {

  _OrderCardState() {
    stateName = OrderCard.state;
  }

  @override
  get init => () async {
    // 'stateData' will contain the current state data
  };
  
  @override
  stateUpdated(dynamic data) async {
    // e.g. to update this state from another class
    // updateState(OrderCard.state, data: "example payload");
  }

  @override
  Widget view(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: widget.status == "Ready for Delivery" ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              widget.status == "Ready for Delivery" ? Icons.check : Icons.access_time,
              color: Colors.white,
            ),
          ),
          SizedBox(
              width:
              10), // Add some spacing between the icon and the text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Section
                Text(
                  "Order ID: #A478A${widget.order_id}",
                  style:
                  TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Text(
                  widget.status == "Ready for Delivery" ? "Order Delivered Successfully" : "Order Processing",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold,color: widget.status == "Ready for Delivery" ? Colors.green : Colors.orange),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Amount :৳ ${widget.total_price}",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Order Date: ${widget.order_date}",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                          ),
                          Text(
                            "Total ${widget.page_count} ${widget.color} Page Printed ",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

           widget.status =="Pending" ? TextButton(onPressed: (){widget.cancelOrder();}

               , child: Text("Cancel Order").bodySmall(color: Colors.red,fontWeight: FontWeight.bold))
               :IconButton(onPressed: (){}, icon: Icon(Icons.file_download)),

        ],
      ),
    ).paddingOnly(bottom: 5, top: 5);
  }
}
