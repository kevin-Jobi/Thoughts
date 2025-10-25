import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thoughts/presentation/dashboard_screen.dart';
import 'package:thoughts/presentation/login_page.dart';
import 'package:thoughts/presentation/splash_screen.dart';
import 'package:thoughts/view_models/splash_view_model.dart';

class SplashWrapper extends StatelessWidget {
  const SplashWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashViewModel(),
      child: Consumer<SplashViewModel>(
        builder: (context, viewModel, _) {
          if (!viewModel.isLoading) {
            if (viewModel.isAuthenticated) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const DashboardScreen()),
                );
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              });
            }
          }
          return const SplashScreen();
        },
      ),
    );
  }
}