import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_gallery/firebase_options.dart';
import 'package:wallpaper_gallery/modal/daily_gallery.dart';
import 'package:wallpaper_gallery/modal/download_image.dart';
import 'package:wallpaper_gallery/modal/setting.dart';
import 'package:wallpaper_gallery/provider/settingProvider.dart';
import 'package:wallpaper_gallery/screen/authentication_screen.dart';
import 'package:wallpaper_gallery/screen/tab_screen.dart';
import 'package:wallpaper_gallery/screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initIsar();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> initIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  await Isar.open(
    [DailyGallerySchema, DownlaodImageSchema],
    directory: dir.path,
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setting = ref.watch<Setting>(settingProvider);

    // print(setting);
    return MaterialApp(
      title: 'WallFeast',
      themeMode: setting.useDarkTheme ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 38, 2, 53),
            dynamicSchemeVariant: DynamicSchemeVariant.vibrant),
        useMaterial3: true,
      ),
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 214, 91, 91),
            dynamicSchemeVariant: DynamicSchemeVariant.vibrant),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            return const TabScreen();
          }

          return const AuthenticationScreen();
        },
      ),
    );
  }
}
