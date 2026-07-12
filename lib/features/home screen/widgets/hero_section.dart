import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 24.0,
          bottom: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mini Mart",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "CHOSEN\nPIECES",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 48,
                fontWeight: FontWeight.w400,
                height: 1.05,
                letterSpacing: 1.5,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Divider(color: const Color(0x14FFFFFF), thickness: 1),
          ],
        ),
      ),
    );
  }
}
