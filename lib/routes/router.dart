import '/resources/pages/order_details_page.dart';
import '/resources/pages/my_orders_page.dart';
import '/resources/pages/coupons_page.dart';
import '/resources/pages/register_page.dart';
import '/resources/pages/login_page.dart';
import '/resources/pages/profile_page.dart';
import '/resources/pages/base_navigation_hub.dart';
import '/resources/pages/not_found_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

/* App Router
|--------------------------------------------------------------------------
| * [Tip] Create pages faster 🚀
| Run the below in the terminal to create new a page.
| "dart run nylo_framework:main make:page profile_page"
|
| * [Tip] Add authentication 🔑
| Run the below in the terminal to add authentication to your project.
| "dart run scaffold_ui:main auth"
|
| * [Tip] Add In-app Purchases 💳
| Run the below in the terminal to add In-app Purchases to your project.
| "dart run scaffold_ui:main iap"
|
| Learn more https://nylo.dev/docs/6.x/router
|-------------------------------------------------------------------------- */

appRouter() => nyRoutes((router) {
      //router.add(HomePage.path).initialRoute();
      // Add your routes here ...

      // router.add(NewPage.path, transition: PageTransitionType.fade);

      // Example using grouped routes
      // router.group(() => {
      //   "route_guards": [AuthRouteGuard()],
      //   "prefix": "/dashboard"
      // }, (router) {
      //
      // });
      router.add(NotFoundPage.path).unknownRoute();
      router.add(BaseNavigationHub.path).authenticatedRoute();
       router.add(ProfilePage.path);
      router.add(LoginPage.path).initialRoute();
  router.add(RegisterPage.path);
  router.add(CouponsPage.path);
  router.add(MyOrdersPage.path);
  router.add(OrderDetailsPage.path);
});


//php artisan serve --host=0.0.0.0 --port=8080