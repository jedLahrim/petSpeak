import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petspeak_ai/app/common/icons/ask_vet.dart';
import 'package:petspeak_ai/app/common/icons/reels.dart';
import 'package:petspeak_ai/app/routes/app_routes.dart';
import 'package:petspeak_ai/app/utils/constants/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            index: 0,
            label: 'Home',
            icon: Icons.home_rounded,
            routeName: Routes.HOME,
          ),
          _buildNavItem(
            index: 1,
            label: 'Translate',
            icon: Icons.mic,
            routeName: Routes.TRANSLATIONS,
          ),
          _buildNavItem(
            index: 2,
            label: 'Reels',
            icon: ReelIcon.reels,
            routeName: Routes.REELS,
          ),
          _buildNavItem(
            index: 3,
            label: 'Ask Vet',
            icon: AskVetIcon.askVet,
            routeName: Routes.ASK_VET,
          ),
          _buildNavItem(
            index: 4,
            label: 'Profile',
            icon: Icons.person,
            routeName: Routes.PET_PROFILE,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required IconData icon,
    required String routeName,
  }) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        onTap(index);
        Get.toNamed(routeName);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 70,
        padding: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          // border: Border(
          //   top: BorderSide(
          //     color: isSelected ? AppColors.primary : Colors.transparent,
          //     width: 3,
          //   ),
          // ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}