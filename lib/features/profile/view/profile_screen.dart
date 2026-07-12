import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, color: Colors.white, size: 22),
        ),
        title: Text(
          "PROFILE",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 24.0,
            bottom: 100.0, // Space for floating bottom navigation bar
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // User Name
              Text(
                "Vedant Parulekar",
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 38,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 6),

              // Member Since
              Text(
                "MEMBER SINCE 2023",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0x99FFFFFF),
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 48),

              // Menu Items
              Column(
                children: [
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0x12FFFFFF),
                  ),
                  _buildMenuItem("Order History", () {}),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0x12FFFFFF),
                  ),
                  _buildMenuItem("Shipping Address", () {}),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0x12FFFFFF),
                  ),
                  _buildMenuItem("Payment Methods", () {}),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0x12FFFFFF),
                  ),
                  _buildMenuItem("Wishlist", () {}),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0x12FFFFFF),
                  ),
                  _buildMenuItem("Settings", () {}),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0x12FFFFFF),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Log Out Button
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: const Size(120, 44),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: Text(
                  "LOG OUT",
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFFFF5A5A),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xE6FFFFFF),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Color(0x33FFFFFF),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
