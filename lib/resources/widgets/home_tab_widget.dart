import 'package:flutter/material.dart';
import 'package:flutter_app/app/models/order.dart';
import 'package:flutter_app/app/models/product.dart';
import 'package:flutter_app/resources/widgets/logo_widget.dart';
import 'package:flutter_app/resources/widgets/product_card_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../app/networking/customer_api_service.dart';
import '../../bootstrap/helpers.dart';
import '../pages/login_page.dart';
import '../pages/order_details_page.dart';
import '../pages/template_order_details_page.dart';
import 'buttons/buttons.dart';
import 'order_tracking_card_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  static String state = "home_tab";

  @override
  createState() => _HomeTabState();
}

class _HomeTabState extends NyState<HomeTab> {
  @override
  get init => () async {
    await setLoading(true);
    await Future.wait([
      _apiService.getAllProducts().then((value) {
        products = value;
        setState(() {
          products = products;
        });
      }),
      _apiService.trackOrders().then((value) async {
        order = value;
        setState(() {
          order = order;
        });
      }),
    ]);
    await setLoading(false);
  };

  _HomeTabState() {
    stateName = HomeTab.state;
  }

  @override
  stateUpdated(dynamic data) async {
    setState(() {});
  }

  Map user = {};
  CustomerApiService _apiService = CustomerApiService();
  List<Product> products = [];
  Order? order;

  @override
  LoadingStyle get loadingStyle => LoadingStyle.skeletonizer();

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("PrintX").displayMedium(fontWeight: FontWeight.bold, color: Colors.black, fontFamily: "Poppins"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none, color: Colors.black)),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 15,
            backgroundImage: NetworkImage(
                "https://cdn-icons-png.flaticon.com/512/8744/8744028.png"),
          ).paddingOnly(right: 8),
        ],
      ),
      body: SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          controller: RefreshController(),
          physics: BouncingScrollPhysics(),
          onRefresh: () async {
            await init();
          },
          child: SingleChildScrollView(
            child: Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    order != null && order?.status != "Ready for Delivery"
                        ? OrderTrackingCard(
                            order_id: order?.id.toString() ?? "0",
                            page_count: order?.pageCount.toString() ?? "0",
                            total_price: order?.totalPrice.toString() ?? "0.00",
                            status: order?.status ?? "Preparing your order",
                            color: order?.color ?? "Color",
                          )
                        : Container(
                            width: 10,
                            height: 10,
                          ),
                    Text("All Products")
                        .titleMedium(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                            color: ThemeColor.get(context).primaryAccent)
                        .paddingSymmetric(horizontal: 20),
                    Text("Here are some of the products you might like")
                        .bodySmall(fontFamily: "Poppins")
                        .paddingSymmetric(horizontal: 20),
                    SizedBox(height: 10),
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Image.network(
                                    "https://cdn3d.iconscout.com/3d/premium/thumb/arquivo-8334581-6648107.png",
                                    width: 50,
                                    height: 50),
                                SizedBox(height: 5),
                                Text("1 Blank Cover Page")
                                    .bodyMedium(
                                        fontFamily: "Poppins",
                                        color: Colors.grey[800])
                                    .paddingOnly(bottom: 5),
                              ],
                            ),
                          ).paddingSymmetric(horizontal: 10),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Image.network(
                                    "https://cdn3d.iconscout.com/3d/premium/thumb/edit-file-3d-icon-download-in-png-blend-fbx-gltf-formats--note-document-pack-files-folders-icons-6220909.png?f=webp",
                                    width: 50,
                                    height: 50),
                                SizedBox(height: 5),
                                Text("1 Blank Index Page")
                                    .bodyMedium(
                                        fontFamily: "Poppins",
                                        color: Colors.grey[800])
                                    .paddingOnly(bottom: 5),
                              ],
                            ),
                          ).paddingSymmetric(horizontal: 10, vertical: 5),
                        ],
                      ),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      itemCount: products.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ProductCard(
                          title: products[index].title ?? "Product Title",
                          description: products[index].description ??
                              "Product Description",
                          price: products[index].pricePerPage ?? "0.00",
                          onTap: () {
                            routeTo(TemplateOrderDetailsPage.path,
                                data: products[index]);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
