import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petspeak_ai/app/modules/reels/controllers/reels_controller.dart';
import 'package:petspeak_ai/app/utils/constants/app_colors.dart';
import 'package:petspeak_ai/global_widgets/custom_bottom_nav_bar.dart';
import 'package:video_player/video_player.dart';

class ReelsView extends GetView<ReelsController> {
  const ReelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Reels PageView
          PageView.builder(
            scrollDirection: Axis.vertical,
            onPageChanged: controller.onPageChanged,
            itemCount: controller.reels.length,
            itemBuilder: (context, index) {
              final reel = controller.reels[index];
              return _buildReelItem(context, reel);
            },
          ),

          // Top gradient
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // App bar
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pet Reels',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    color: Colors.white,
                    onPressed: () {
                      Get.snackbar(
                        'Coming Soon',
                        'Create Reels feature will be available soon!',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          // Navigation handled by CustomBottomNavBar
        },
      ),
    );
  }

  Widget _buildReelItem(BuildContext context, ReelItem reel) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Video player
        GetBuilder<ReelsController>(
          builder: (controller) {
            if (controller.videoController?.value.isInitialized ?? false) {
              return FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controller.videoController!.value.size.width,
                  height: controller.videoController!.value.size.height,
                  child: VideoPlayer(controller.videoController!),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          },
        ),

        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.5),
              ],
            ),
          ),
        ),

        // Content
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User info
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(reel.userAvatarUrl),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    reel.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Follow',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Caption
              Text(
                reel.caption,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 16),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildActionButton(
                        icon: reel.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        label: reel.likes.toString(),
                        color: reel.isLiked ? Colors.red : Colors.white,
                        onTap: () => controller.toggleLike(reel.id),
                      ),
                      const SizedBox(width: 16),
                      _buildActionButton(
                        icon: Icons.chat_bubble_outline,
                        label: reel.comments.toString(),
                        onTap: () => controller.showComments(reel.id),
                      ),
                      const SizedBox(width: 16),
                      _buildActionButton(
                        icon: Icons.send,
                        label: 'Share',
                        onTap: () => controller.shareReel(reel.id),
                      ),
                    ],
                  ),
                  _buildActionButton(
                    icon: reel.isSaved ? Icons.bookmark : Icons.bookmark_border,
                    label: 'Save',
                    onTap: () => controller.toggleSave(reel.id),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
