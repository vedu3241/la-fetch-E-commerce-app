import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lafetch_ecom/features/nav/controller/nav_controller.dart';

class CartEmptyState extends StatelessWidget {
  const CartEmptyState({super.key, required this.navController});

  final NavController navController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: const Color(0x0AFFFFFF),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0x14FFFFFF), width: 1.5),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Color(0x66FFFFFF),
                size: 40,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "YOUR BAG IS EMPTY",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "Exquisite pieces are waiting for you.\nExplore our collections and choose your favorites.",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: const Color(0x80FFFFFF),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => navController.changeIndex(0),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size(200, 50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                elevation: 0,
              ),
              child: Text(
                "EXPLORE COLLECTION",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
