import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/app/models/product.dart';
import 'package:flutter_app/resources/widgets/safearea_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

import '../../app/networking/customer_api_service.dart';
import '../../bootstrap/helpers.dart';
import '../widgets/buttons/buttons.dart';
import '../widgets/full_loader_widget.dart';
import '../widgets/pdf_thumbnail_widget.dart';
import 'my_orders_page.dart';

class TemplateOrderDetailsPage extends NyStatefulWidget {
  static RouteView path = ("/template-order-details", (_) => TemplateOrderDetailsPage());

  TemplateOrderDetailsPage({super.key}) : super(child: () => _TemplateOrderDetailsPageState());
}

class _TemplateOrderDetailsPageState extends NyPage<TemplateOrderDetailsPage> {
  @override
  get init => () {
    product = widget.data();
  };

  double totalPages = 1;
  double total_price = 0;
  double delivery_charge = 0;
  double sub_total = 5;
  bool isCouponApplied = false;

  Product product = Product();

  String API_BASE_URL = getEnv('API_BASE_URL');

  TextEditingController _noteController = TextEditingController();
  CustomerApiService _customerApiService = CustomerApiService();

  Future _placeTemplateOrder() async {
    FormData data = FormData.fromMap({
      "product_id": product.id,
      "total_pages": 1,
      "total_price": product.pricePerPage,
      "delivery_charge": delivery_charge,
      "color": "Color",
      'note': _noteController.text
    });

    LoadingDialog.show(context);
    _customerApiService.placeOrder(data: data).then((value) {
      LoadingDialog.hide(context);
      Fluttertoast.showToast(
          msg: value == 0 ? "Order Placed" : "Failed to place order",
          backgroundColor: value == 0 ? Colors.green : Colors.red);
      if (value == 0) {
        routeTo(MyOrdersPage.path, navigationType: NavigationType.pushReplace);
      }
    });
  }

Future _downloadPDF() async {
  DownloadProgressDialog.show(context, 0);
  try {
    // Get the document directory path
    Directory appDocDir = await getApplicationDocumentsDirectory(

    );
    String appDocPath = appDocDir.path;

    // Define the file path
    String filePath = '$appDocPath/${product.fileUrl?.split('/').last}';

    // Download the file with progress
    Dio dio = Dio();
    Response response = await dio.download(
      "${API_BASE_URL}/${product.fileUrl}",
      filePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          double progress = (received / total * 100);
          DownloadProgressDialog.update(context, progress.toInt());
        }
      },
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "PDF Downloaded Successfully to $filePath",
          backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(
          msg: "Failed to download PDF",
          backgroundColor: Colors.red);
    }
  } catch (e) {
    Fluttertoast.showToast(
        msg: "Failed to download PDF",
        backgroundColor: Colors.red);
  } finally {
    DownloadProgressDialog.hide(context);
  }
}

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: SafeAreaWidget(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// **PDF Download Section**
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Download PDF", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text("You can download the PDF file of this template", style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _downloadPDF();
                        },
                        icon: const Icon(Icons.download_rounded, color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                /// **PDF Thumbnail**
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: PdfThumbnail(pdfUrl: "${API_BASE_URL}/${product.fileUrl}"),
                  ),
                ),

                const SizedBox(height: 20),

                /// **Product Info**
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Product ID: ${product.id}", style: Theme.of(context).textTheme.bodySmall),
                          const Spacer(),
                         Text("${DateFormat('dd-MM-yyyy').format(product.createdAt.toDateTime())}", style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        product.title ?? "",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.description ?? "",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black54),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Divider(color: Colors.grey[300]),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Pages: ${totalPages.toInt()}", style: Theme.of(context).textTheme.bodyMedium),
                          Text("1 Copy", style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text("Color Format", style: Theme.of(context).textTheme.bodyMedium),
                          const Spacer(),
                          Text("Colorized", style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text("৳ ${product.pricePerPage}",
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold, color: Colors.green)),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// **Note Input Field**
                TextField(
                  controller: _noteController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Add Note (Optional)",
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),

                const SizedBox(height: 30),

                /// **Place Order Button**
                Button.primary(
                  text: "Place Order",
                  onPressed: _placeTemplateOrder,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
