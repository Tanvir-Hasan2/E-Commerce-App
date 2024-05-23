import 'package:e_commerce/Const/app_colors.dart';
import 'package:e_commerce/UI/Views/Nav%20Pages/add_to_cart.dart';
import 'package:e_commerce/UI/Views/Nav%20Pages/favourite.dart';
import 'package:e_commerce/UI/Views/Nav%20Pages/home.dart';
import 'package:e_commerce/UI/Views/Nav%20Pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavController extends StatelessWidget {
  BottomNavController({super.key});

  RxInt _currentIndex = 0.obs;

  final _pages = [
    Home(),
    Favourite(),
    AddToCart(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          //state ta
          // update korar jonno Obx((0 => ) diye return korte hobe
          // r stateful use korle performence kome jai app er.
          //set state user korle app rebuild hoy
          bottomNavigationBar: SalomonBottomBar(
            //for action of the nav bar icon with navigation
            selectedItemColor: AppColors.mandarinColor,
            currentIndex: _currentIndex.value,
            onTap: (val) {
              _currentIndex.value = val;
            },
            items: [
              bottomBarItem(Icons.home_outlined, 'Home'),
              bottomBarItem(Icons.favorite_outline, 'Favourite'),
              bottomBarItem(Icons.shopping_cart_outlined, 'Cart'),
              bottomBarItem(Icons.person_outline, 'Person'),
            ],
          ),
          body: _pages[_currentIndex.value],
        ));
  }
}

SalomonBottomBarItem bottomBarItem(icon, title) => SalomonBottomBarItem(
      icon: Icon(icon),
      title: Text(title),
    );
