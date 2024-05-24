import 'package:e_commerce/Business%20Logics/Bindings/auth_binding.dart';
import 'package:e_commerce/Business%20Logics/Bindings/cart_binding.dart';
import 'package:e_commerce/Business%20Logics/Bindings/checkout_binding.dart';
import 'package:e_commerce/Business%20Logics/Bindings/favourite_binding.dart';
import 'package:e_commerce/Business%20Logics/Bindings/splash_binding.dart';
import 'package:e_commerce/UI/Views/Auth/forget_password.dart';
import 'package:e_commerce/UI/Views/Auth/login.dart';
import 'package:e_commerce/UI/Views/Auth/registration.dart';
import 'package:e_commerce/UI/Views/Nav%20Pages/home.dart';
import 'package:e_commerce/UI/Views/bottom_nav_controller.dart';
import 'package:e_commerce/UI/Views/not_found.dart';
import 'package:e_commerce/UI/Views/onboarding.dart';
import 'package:e_commerce/UI/Views/splash.dart';
import 'package:e_commerce/UI/Views/terms_conditions.dart';
import 'package:get/get.dart';

const String splash = '/splash-screen';
const String unknown = '/not-found';
//kono page na thakle unknown eta return korbe.
const String intro = '/intro';
const String login = '/login';
const String registration = '/registration';
const String forgetPass = '/forgetPass';
const String termCon = '/termCondition';
const String bottomNav = '/bottomNav';
const String details = '/details';

List<GetPage> getPages = [
  GetPage(
    name: unknown,
    page: () => const Unknown(),
  ),
  // like this way show all routes
  GetPage(
    name: splash,
    page: () => Splash(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: intro,
    page: () => Onboarding(),
  ),
  GetPage(
    name: login,
    page: () => Login(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: registration,
    page: () => Registration(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: forgetPass,
    page: () => ForgetPassword(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: termCon,
    page: () => TermCondition(),
  ),
  GetPage(
    name: bottomNav,
    page: () => BottomNavController(),
    bindings: [
      CartBinding(),
      FavouriteBinding(),
      CheckoutBinding(),
    ],
  ),
  GetPage(
    name: details,
    page: () => DetailsScreen(data: Get.arguments),
  ),
];
