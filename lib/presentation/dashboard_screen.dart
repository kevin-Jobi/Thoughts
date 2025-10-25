
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/bloc/nav_bar/nav_bar_bloc.dart';
import 'package:thoughts/bloc/nav_bar/nav_bar_event.dart';
import 'package:thoughts/bloc/nav_bar/nav_bar_state.dart';
import 'package:thoughts/presentation/widget/custom_bottom_nav_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarBloc()..add(const NavItemSelected(0)),
      child: const _DashboardScreenContent(),
    );
  }
}

class _DashboardScreenContent extends StatelessWidget {
  const _DashboardScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2443),
      body: Column(
        children: [
      
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color(0xFF1E2758),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Image.asset(
                    'assets/images/dashboard_signal.jpeg', // Replace with image path 
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback if image not found
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF1E2758),
                              Color(0xFF2B4D6E),
                              Color(0xFF3D7B7F),
                              Color(0xFF4FA890),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.image_not_supported,
                                color: Colors.white54,
                                size: 48,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Image not found',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Place your image at:\nassets/images/dashboard_signal.png',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder<NavBarBloc, NavBarState>(
        builder: (context, state) {
          return CustomBottomNavBar(
            selectedIndex: state.selectedIndex,
            onItemTapped: (index) {
              context.read<NavBarBloc>().add(NavItemSelected(index));
            },
            routes: [
              '/dashboard', // Dashboard
              '/maintenance', // Maintenance
              '/diagnostics', // Diagnostics
              '/settings', // Settings
            ],
          );
        },
      ),
    );
  }
}