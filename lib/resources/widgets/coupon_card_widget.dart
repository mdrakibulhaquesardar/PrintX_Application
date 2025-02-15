import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class CouponCard extends StatefulWidget {

  final String code;
  final String discountValue;
  final String minOrderAmount;
  final String expiresAt;
  final int usageLimit;



  
  const CouponCard({super.key, required this.code, required this.discountValue, required this.minOrderAmount, required this.expiresAt, required this.usageLimit});
  
  static String state = "coupon_card";

  @override
  createState() => _CouponCardState();
}

class _CouponCardState extends NyState<CouponCard> {

  _CouponCardState() {
    stateName = CouponCard.state;
  }

  @override
  get init => () async {
    // 'stateData' will contain the current state data
  };
  
  @override
  stateUpdated(dynamic data) async {
    // e.g. to update this state from another class
    // updateState(CouponCard.state, data: "example payload");
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
       border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.local_offer, color: Colors.green, size: 20),
                  SizedBox(width: 5),
                  Text(
                    "Random Discount",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),

          // Discount & Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.code}",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "৳ ${widget.discountValue}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ],
          ),
          Text(
            "Minimum Order: ৳ ${widget.minOrderAmount}",
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          ),

          SizedBox(height: 10),

          // Expiry, Uses & Duration
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfo(Icons.calendar_today, "Expires:", widget.expiresAt),
              _buildInfo(Icons.check_circle_outline, "Use Limit:", "x${widget.usageLimit}"),
              _buildInfo(Icons.timer, "Duration:", "Unlimited"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.black54),
        SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 10, color: Colors.black54)),
            Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
      ],
    );
  }
}
