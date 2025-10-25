import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/bloc/nav_bar/nav_bar_bloc.dart';
import 'package:thoughts/bloc/nav_bar/nav_bar_event.dart';
import 'package:thoughts/bloc/nav_bar/nav_bar_state.dart';
import 'package:thoughts/presentation/widget/custom_bottom_nav_bar.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarBloc()..add(const NavItemSelected(1)),
      child: BlocBuilder<NavBarBloc, NavBarState>(
        builder: (context, state) {
          return Scaffold(
            body: const Center(child: Text('Maintenance')),
            bottomNavigationBar: CustomBottomNavBar(
              selectedIndex: state.selectedIndex,
              onItemTapped: (index) {
                context.read<NavBarBloc>().add(NavItemSelected(index));
              },
              routes: [
                '/dashboard',
                '/maintenance',
                '/diagnostics',
                '/settings',
              ],
            ),
          );
        },
      ),
    );
  }
}

