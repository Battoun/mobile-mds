import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'router/app_router.dart';

void main() {
  // Étape 4 — preuve que le ViewModel est observable : un simple listener,
  // sans Provider ni widget, qui réagit à chaque notifyListeners().
  dashboardViewModel.addListener(() {
    debugPrint('[DashboardViewModel] state -> ${dashboardViewModel.state.runtimeType}');
  });

  // La View écoute désormais le ViewModel : plus besoin d'attendre le
  // chargement avant runApp, l'écran affiche Loading puis le résultat.
  dashboardViewModel.load();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color iosBlue = Color(0xFF007AFF);
    const Color groupedBackground = Color(0xFFF2F2F7);

    return MaterialApp.router(
      title: 'SensorHub',
      routerConfig: appRouter,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: iosBlue,
          primary: iosBlue,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: groupedBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: groupedBackground,
          foregroundColor: Colors.black,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        dividerTheme: const DividerThemeData(
          space: 1,
          thickness: 0.5,
          color: Color(0xFFE5E5EA),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
    );
  }
}
