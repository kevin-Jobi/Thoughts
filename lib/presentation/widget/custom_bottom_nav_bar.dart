import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final List<String> routes;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.routes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFC73333),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.dashboard_outlined,
            label: 'Dashboard',
            index: 0,
            context: context,
          ),
          _buildNavItem(
            icon: Icons.build_outlined,
            label: 'Maintenance',
            index: 1,
            context: context,
          ),
          _buildNavItem(
            icon: Icons.search,
            label: 'Diagnostics',
            index: 2,
            context: context,
          ),
          _buildNavItem(
            icon: Icons.settings_outlined,
            label: 'Settings',
            index: 3,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required BuildContext context,
  }) {
    final isSelected = selectedIndex == index;
    return InkWell(
      onTap: () {
        onItemTapped(index);
        if (index < routes.length && routes[index].isNotEmpty) {
          Navigator.pushNamed(context, routes[index]);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white70,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}