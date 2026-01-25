import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forui/forui.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vpn_basic_project/helpers/hive_pref.dart';
import 'package:vpn_basic_project/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  await HivePref.initializeHive();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FThemes.zinc.dark;
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return GetMaterialApp(
      supportedLocales: FLocalizations.supportedLocales,
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      theme: theme.toApproximateMaterialTheme(),
      darkTheme: theme.toApproximateMaterialTheme(),
      fallbackLocale: const Locale('en', 'US'),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
