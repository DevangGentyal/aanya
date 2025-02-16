// Packages
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:Aanya/database/storage_service.dart';
import 'package:Aanya/database/supabase_service.dart';

// Widgets and Pages
import 'package:Aanya/pages/mobile_pages/getting_started_page.dart';
import 'package:Aanya/pages/desktop_pages/getting-started-page.dart';
import 'package:Aanya/pages/desktop_pages/home-page.dart';
import 'package:Aanya/pages/desktop_pages/loading-scene.dart';
import 'package:Aanya/pages/desktop_pages/login-reg-page.dart';
import 'package:Aanya/pages/desktop_pages/device-checking.dart';
import 'package:Aanya/pages/mobile_pages/device-checking.dart';
import 'package:Aanya/pages/mobile_pages/home-page.dart';
import 'package:Aanya/pages/mobile_pages/loading-scene.dart';
import 'package:Aanya/pages/mobile_pages/login-reg-page.dart';

// Others
import 'package:Aanya/common_vars.dart';

// Global Variables
bool isDesktop = false;
late Map<String, Widget Function(BuildContext)> routes;

void main() async {
  // Ensure that Flutter binding is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage
  await GetStorage.init();

  // Supabase Service Initialize
  await Get.putAsync<SupabaseService>(() async => SupabaseService());

  // Hide default status bar and navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: SystemUiOverlay.values);

  // Wait for initialization to complete before running the app.
  await Future.delayed(Duration.zero);

  // Check whether the platform is Desktop or Mobile
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    isDesktop = true;
    await DesktopAppConfigure();
  } else {
    isDesktop = false;
  }
  // Initializing Routes
  await setRoutes();
  // Primary/Main Function used to run the Flutter App
  runApp(
    ChangeNotifierProvider(
      create: (_) => CommonVariables(),
      child: MyApp(),
    ),

    // ChangeNotifierProvider is used for synchrounus updation and accessing Common Objects/Variables
  );
}

// Main Root for the App
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // Setting constants
    setConstants(context, Platform.isWindows);
    return MaterialApp(
      initialRoute:
          StorageService.getUserSession != null ? '/loading_scene' : '/',
      routes: routes,
      title: 'Aanya',
      debugShowCheckedModeBanner: false,
    );
  }
}
// Setting Routes
Future<void> setRoutes() async {
  if (isDesktop) {
    routes = await {
      '/': (context) => DesktopGettingStarted(),
      '/login_reg': (context) => DesktopLoginReg(),
      '/loading_scene': (context) => DesktopLoadingScene(),
      '/home': (context) => DesktopHomePage(),
      '/device-checking': (context) => DesktopDeviceChecking(),
    };
  } else {
    routes = await {
      '/': (context) => MobileGettingStarted(),
      '/login_reg': (context) => MobileLoginReg(),
      '/loading_scene': (context) => MobileLoadingScene(),
      '/home': (context) => MobileHomePage(),
      '/device-checking': (context) => MobileDeviceChecking(),
    };
  }
}
Future<void> DesktopAppConfigure() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();
  windowManager.setResizable(false);
  windowManager.setIcon("assets/images/favicon.png");
  WindowOptions windowOptions = WindowOptions(
    size: Size(1440 / 1.5, 1000 / 1.5),
    center: true,
    backgroundColor: Color.fromARGB(0, 0, 0, 0),
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}


