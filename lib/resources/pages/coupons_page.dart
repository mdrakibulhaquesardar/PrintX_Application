import 'package:flutter/material.dart';
import 'package:flutter_app/resources/widgets/safearea_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../app/models/coupon.dart';
import '../../app/networking/customer_api_service.dart';
import '../widgets/coupon_card_widget.dart';

class CouponsPage extends NyStatefulWidget {
  static RouteView path = ("/coupons", (_) => CouponsPage());

  CouponsPage({super.key}) : super(child: () => _CouponsPageState());
}

class _CouponsPageState extends NyPage<CouponsPage> {
  @override
  get init => () async {
        _apiService.getAllCoupons().then((value) {
          coupons = value;
          setState(() {
            coupons = coupons;
          });
        });

      };

  CustomerApiService _apiService = CustomerApiService();

  List<Coupon> coupons = [];

  @override
  LoadingStyle get loadingStyle => LoadingStyle.skeletonizer();

  String getFormattedDate(String date) {
    // Convert date to local time and remove the time
    DateTime dateTime = DateTime.parse(date).toLocal();
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Coupons")),
      body: SafeAreaWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("All Coupons").titleLarge(fontWeight: FontWeight.bold),
            Text("You Can Apply All Coupons For Your Orders").bodySmall(),
            SizedBox(height: 20),
            if (coupons.isEmpty)
              Center(child: Text("No coupons available").bodyMedium()),
            ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: "${coupons[index].code}"));
                    Fluttertoast.showToast(msg: "${coupons[index].code} | Coupon code copied", backgroundColor: Colors.green);
                  },
                  child: ColorFiltered(
                    colorFilter: coupons[index].usageLimit == 0 ?  ColorFilter.mode(Colors.white, BlendMode.saturation) : ColorFilter.mode(Colors.transparent, BlendMode.color),
                    child: CouponCard(
                      code: "${coupons[index].code}",
                      discountValue: "${coupons[index].discountValue}",
                      minOrderAmount: "${coupons[index].minOrderAmount}",
                      expiresAt: getFormattedDate("${coupons[index].expiresAt}"),
                      usageLimit: coupons[index].usageLimit ?? 0,
                    ),
                  ),
                );
              },
              itemCount: coupons.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10);
              },
            ),
          ],
        ),
      ),
    );
  }
}