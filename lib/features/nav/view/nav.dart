import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lafetch_ecom/features/home%20screen/views/home_screen.dart';
import 'package:lafetch_ecom/features/cart/view/cart_screen.dart';
import 'package:lafetch_ecom/features/profile/view/profile_screen.dart';
import 'package:lafetch_ecom/features/nav/controller/nav_controller.dart';

class NavView extends StatelessWidget {
  NavView({super.key});

  final List<Widget> pages = [
    const HomeScreen(),
    const CartScreen(),
    // const FavouritesScreen(),
    const ProfileScreen(),
  ];

  final controller = Get.find<NavController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: const Color(0xFF0F0F0F),
        body: Stack(
          children: [
            IndexedStack(index: controller.currentIndex.value, children: pages),
            _buildGlassBottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassBottomNavBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left: 28, right: 28, bottom: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0x93000000),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0x14FFFFFF), width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.home_filled),
                  _buildNavItem(1, Icons.shopping_bag),
                  // _buildNavItem(2, Icons.favorite_border),
                  _buildNavItem(2, Icons.person_outline),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    final isSelected = controller.currentIndex.value == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => controller.changeIndex(index),
      child: Container(
        height: 65,
        width: 65,
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: isSelected ? const Color(0xff8E66CF) : const Color(0x66FFFFFF),
          size: 26,
        ),
      ),
    );
  }
}
