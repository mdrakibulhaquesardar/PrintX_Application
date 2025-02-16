import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ProductCard extends StatefulWidget {

  final String title;
  final String description;
  final String price;
  final Function? onTap;
  
  const ProductCard({super.key, required this.title, required this.description, required this.price, this.onTap});
  
  static String state = "product_card";

  @override
  createState() => _ProductCardState();
}

class _ProductCardState extends NyState<ProductCard> {

  _ProductCardState() {
    stateName = ProductCard.state;
  }

  @override
  get init => () async {
    // 'stateData' will contain the current state data
  };
  
  @override
  stateUpdated(dynamic data) async {
    // e.g. to update this state from another class
    // updateState(ProductCard.state, data: "example payload");
  }

  @override
  Widget view(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Icon
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "https://img.freepik.com/free-vector/blue-folder-with-information-about-employee-3d-illustration-cartoon-drawing-folder-with-files-documents-3d-style-white-background-business-recruitment-management-organization-concept_778687-707.jpg", // Replace with actual icon URL
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),

            // App Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Name & More icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  // Developer Name
                  Text(
                    "Elite author",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),

                  SizedBox(height: 5),

                  // Description
                  Text(
                    widget.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),

                  SizedBox(height: 10),

                  // Buttons
                  Row(
                    children: [
                      // Product Details Like Price, Rating, etc.
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "৳ ${widget.price} /P",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ).paddingSymmetric(vertical: 5),
    );
  }
}
