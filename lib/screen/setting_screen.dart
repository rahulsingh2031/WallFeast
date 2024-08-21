import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_gallery/modal/setting.dart';
import 'package:wallpaper_gallery/provider/settingProvider.dart';

import '../widgets/change_password_dialog.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  final passwordController = TextEditingController();

  bool get isUserAnonymous {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.isAnonymous;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void showPasswordChangeDialog() {
    showDialog(
      context: context,
      builder: (ctx) => ChangePasswordDialog(
          passwordController: passwordController,
          mounted: mounted,
          context: context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final setting = ref.watch<Setting>(settingProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16)),
            color: Theme.of(context).colorScheme.primaryContainer),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                subtitle: Text(
                  "Toggle theme between dark and light",
                  style: GoogleFonts.lato().copyWith(fontSize: 12),
                ),
                value: setting.useDarkTheme,
                onChanged: (value) {
                  ref
                      .read(settingProvider.notifier)
                      .setSetting(Setting(useDarkTheme: !setting.useDarkTheme));
                },
                title: Text(
                  "Dark Theme",
                  style: GoogleFonts.lato(),
                ),
              ),
              if (!isUserAnonymous)
                TextButton.icon(
                  onPressed: showPasswordChangeDialog,
                  label: Text(
                    "Change Password",
                    style: GoogleFonts.lato().copyWith(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.inverseSurface),
                  ),
                  icon: Icon(Icons.password,
                      color: Theme.of(context).colorScheme.inverseSurface),
                ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
                label: Text("Logout",
                    style: GoogleFonts.lato().copyWith(fontSize: 18)),
                icon: const Icon(Icons.exit_to_app_rounded),
              )
            ],
          ),
        ),
      ),
    );
  }
}
