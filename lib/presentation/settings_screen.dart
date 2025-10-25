import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/bloc/nav_bar/nav_bar_bloc.dart';
import 'package:thoughts/bloc/nav_bar/nav_bar_event.dart';
import 'package:thoughts/bloc/nav_bar/nav_bar_state.dart';
import 'package:thoughts/presentation/profile_optionslist.dart';
import 'package:thoughts/presentation/widget/custom_bottom_nav_bar.dart';
import 'package:thoughts/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarBloc()..add(const NavItemSelected(3)),
      child: const _SettingsScreenContent(),
    );
  }
}

class _SettingsScreenContent extends StatelessWidget {
  const _SettingsScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warning.withValues(alpha: .9),
      body: SafeArea(child: _buildBody(context)),
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

  Widget _buildBody(BuildContext context) {
    
    return RefreshIndicator(
      onRefresh: () async {},
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: _ModernHeader()),
          SliverFillRemaining(
            hasScrollBody: false,
            child: _buildProfileOptions(),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOptions() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: const ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        child: ProfileOptionsList(),
      ),
    );
  }
}

class _ModernHeader extends StatelessWidget {
  const _ModernHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.person_rounded,
              color: AppColors.surface,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onBackground,
                  ),
                ),
                const Text(
                  'Manage your account settings',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}