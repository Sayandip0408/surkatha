import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:surkatha/screens/app_info_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  final String shareText = "Check out the Surkatha app and all its amazing content! "
      "Download from here: https://drive.google.com/drive/folders/1dRwQGB28tPgARDhySbuunfHlon-kVNNp?usp=sharing";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFff6a00), Color(0xFFee0979)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 16),
            _buildGlassCard(
              icon: Icons.share,
              title: 'Share app',
              subtitle: 'Share Surkatha with friends',
              onTap: () {
                SharePlus.instance.share(
                  ShareParams(
                    text: "Check out the Surkatha app and all its amazing content! "
                        "Download from here: https://drive.google.com/drive/folders/1dRwQGB28tPgARDhySbuunfHlon-kVNNp?usp=sharing",
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildGlassCard(
              icon: Icons.info_outline,
              title: 'App info & developer',
              subtitle: '--------------------------------------------',
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => AppInfoScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(
              (0.1 * 255).round(),
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white.withAlpha(
                (0.2 * 255).round(),
              ),
            ),
          ),
          child: ListTile(
            leading: Icon(icon, color: Colors.white),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              subtitle,
              style: const TextStyle(color: Colors.white70),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
