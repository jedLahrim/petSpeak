import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petspeak_ai/app/utils/constants/app_colors.dart';

class PetAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final String petType;
  final VoidCallback? onTap;
  final bool showBorder;
  final Color? borderColor;
  final double borderWidth;
  final Widget? badge;
  final Color defaultBackgroundColor;

  const PetAvatar({
    super.key,
    this.imageUrl,
    this.size = 60,
    required this.petType,
    this.onTap,
    this.showBorder = true,
    this.borderColor,
    this.borderWidth = 2,
    this.badge,
    this.defaultBackgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor =
        petType == 'dog' ? AppColors.dogMode : AppColors.catMode;

    final border = showBorder
        ? Border.all(
            color: borderColor ?? defaultColor,
            width: borderWidth,
          )
        : null;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Avatar
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: border,
              color: defaultBackgroundColor,
            ),
            child: ClipOval(
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildPlaceholder(),
                      errorWidget: (context, url, error) => _buildPlaceholder(),
                    )
                  : _buildPlaceholder(),
            ),
          ),

          // Badge (if any)
          if (badge != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: badge!,
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: petType == 'dog'
          ? AppColors.dogMode.withOpacity(0.2)
          : AppColors.catMode.withOpacity(0.2),
      child: Center(
        child: Icon(
          petType == 'dog' ? Icons.pets : Icons.emoji_nature,
          color: petType == 'dog' ? AppColors.dogMode : AppColors.catMode,
          size: size * 0.5,
        ),
      ),
    );
  }
}
