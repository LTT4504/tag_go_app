import 'package:get/get.dart';
import '../modules/add_spot/add_spot_binding.dart';
import '../modules/add_spot/add_spot_view.dart';
import '../modules/auth/login_binding.dart';
import '../modules/auth/login_view.dart';
import '../modules/friends_map/fen_map_binding.dart';
import '../modules/friends_map/fen_map_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/intro/intro_binding.dart';
import '../modules/intro/intro_view.dart';
import '../modules/my_map/my_map_binding.dart';
import '../modules/my_map/my_map_view.dart';
import '../modules/profile/profile_binding.dart';
import '../modules/profile/profile_view.dart';
import '../modules/splash/splash_binding.dart';

import '../modules/splash/splash_screen.dart';
import '../modules/spot_detail/spot_detail_binding.dart';
import '../modules/spot_detail/spot_detail_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.intro,
      page: () => const IntroView(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.addSpot,
      page: () => const AddSpotView(),
      binding: AddSpotBinding(),
    ),
    GetPage(
      name: AppRoutes.spotDetail,
      page: () => const SpotDetailView(),
      binding: SpotDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.myMap,
      page: () => const MyMapView(),
      binding: MyMapBinding(),
    ),
    GetPage(
      name: AppRoutes.friendsMap,
      page: () => const FriendsMapView(),
      binding: FriendsMapBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
