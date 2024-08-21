import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_gallery/provider/daily_gallery_provider.dart';
import 'package:wallpaper_gallery/provider/download_gallery_provider.dart';
import 'package:wallpaper_gallery/provider/settingProvider.dart';
import 'package:wallpaper_gallery/screen/setting_screen.dart';

import 'pages/home_page.dart';
import 'pages/save_pages.dart';
import 'pages/search_page.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int currentActiveIndex = 0;

  late Widget content;
  @override
  void initState() {
    super.initState();

    changePage(currentActiveIndex);
    ref.read(settingProvider.notifier).initializeOnLoad();
    ref.read(dailyGalleryProvider.notifier).initializeOnLoad();
    ref.read(downloadGalleryProvider.notifier).initializeOnLoad();
  }

  void changePage(int index) {
    switch (index) {
      case 0:
        content = const HomePage();
      case 1:
        content = const SearchPage();
      case 2:
        content = const SavePages();
    }
  }

  void performLogout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      drawer: NavigationDrawer(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        children: [
          DrawerHeader(
            child: Image.asset("assets/icon/logo_2.png"),
          ),
          ListTile(
            leading: const Icon(Icons.home_filled),
            title: Text(
              "Home",
              style: GoogleFonts.lato(),
            ),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text("Setting", style: GoogleFonts.lato()),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const SettingScreen(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_outlined),
            title: Text("Logout", style: GoogleFonts.lato()),
            onTap: performLogout,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          elevation: 5,
          currentIndex: currentActiveIndex,
          onTap: (value) {
            setState(() {
              currentActiveIndex = value;
            });
            changePage(currentActiveIndex);
          },
          selectedLabelStyle: GoogleFonts.lato(),
          unselectedLabelStyle: GoogleFonts.lato(),
          items: const [
            BottomNavigationBarItem(
              label: "home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "search",
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              label: "gallery",
              icon: Icon(Icons.image),
            ),
          ]),
      body: content,
    );
  }
}
