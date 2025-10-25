import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({super.key});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  String appVersion = "";

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = info.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "App Info",
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFff6a00), Color(0xFFee0979)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const SizedBox(height: 32),

            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha((0.1 * 255).round()),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withAlpha((0.2 * 255).round()),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                        child: Image.asset("assets/images/surkatha.png"),
                    )
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            _buildGlassCard(
              child: ListTile(
                leading: const Icon(Icons.info_outline, color: Colors.white),
                title: const Text(
                  "Version",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  appVersion.isEmpty ? "Loading..." : appVersion,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ),

            const SizedBox(height: 16),

            _buildGlassCard(
              child: ListTile(
                leading: const Icon(
                  Icons.lightbulb_outline,
                  color: Colors.white,
                ),
                title: const Text(
                  "How it works",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  "Surkatha scans your device for audio files and lets you play, like, and manage your music with a smooth liquid glass interface.",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),

            const SizedBox(height: 16),

            _buildGlassCard(
              child: ListTile(
                leading: const Icon(Icons.person_outline, color: Colors.white),
                title: const Text(
                  "Developer",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  "Sayandip Adhikary\nEmail: example@email.com\nGitHub: github.com/username",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),

            const SizedBox(height: 32),

            _buildGlassCard(
              child: TextButton.icon(
                onPressed: () {
                  SharePlus.instance.share(
                    ShareParams(
                      text:
                          "Check out the Surkatha app and all its amazing content! "
                          "Download from here: https://drive.google.com/drive/folders/1dRwQGB28tPgARDhySbuunfHlon-kVNNp?usp=sharing",
                    ),
                  );
                },
                icon: const Icon(Icons.share, color: Colors.white),
                label: const Text(
                  "Share App",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha((0.1 * 255).round()),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withAlpha((0.2 * 255).round()),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
