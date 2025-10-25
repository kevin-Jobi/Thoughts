import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thoughts/firebase_options.dart';
import 'package:thoughts/presentation/dashboard_screen.dart';
import 'package:thoughts/presentation/diagnostics_screen.dart';
import 'package:thoughts/presentation/login_page.dart';
import 'package:thoughts/presentation/maintenance_screen.dart';
import 'package:thoughts/presentation/registration_screen.dart';
import 'package:thoughts/presentation/settings_screen.dart';
import 'package:thoughts/splash_wraper.dart';
import 'package:thoughts/view_models/theme_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, themeViewModel, _) {
          return MaterialApp(
            title: 'Dynamic Theming App',
            theme: themeViewModel.themeData,
            debugShowCheckedModeBanner: false,
            home: const SplashWrapper(),
            routes: {
              '/register': (context) => const RegisterScreen(),
              '/dashboard': (context) => const DashboardScreen(),
              '/maintenance': (context) => const MaintenanceScreen(),
              '/diagnostics': (context) => const DiagnosticsScreen(),
              '/settings': (context) => const SettingsScreen(),
              '/login': (context) => const LoginPage(),
            },
          );
        },
      ),
    );
  }
}