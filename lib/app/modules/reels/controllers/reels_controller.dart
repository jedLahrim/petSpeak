import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ReelItem {
  final String id;
  final String videoUrl;
  final String userAvatarUrl;
  final String username;
  final String caption;
  final int likes;
  final int comments;
  final bool isLiked;
  final bool isSaved;

  ReelItem({
    required this.id,
    required this.videoUrl,
    required this.userAvatarUrl,
    required this.username,
    required this.caption,
    required this.likes,
    required this.comments,
    this.isLiked = false,
    this.isSaved = false,
  });
}

class ReelsController extends GetxController {
  final RxList<ReelItem> reels = <ReelItem>[].obs;
  final RxInt currentIndex = 0.obs;
  VideoPlayerController? videoController;

  @override
  void onInit() {
    super.onInit();
    _loadReels();
  }

  @override
  void onClose() {
    videoController?.dispose();
    super.onClose();
  }

  void _loadReels() {
    // Mock data - replace with API call
    reels.value = [
      ReelItem(
        id: '1',
        videoUrl: 'https://example.com/video1.mp4',
        userAvatarUrl:
            'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg',
        username: 'max_and_bella',
        caption: 'Max just told me he loves the beach! 🐾🌊 #PetTranslation',
        likes: 342,
        comments: 42,
      ),
      ReelItem(
        id: '2',
        videoUrl: 'https://example.com/video2.mp4',
        userAvatarUrl:
            'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg',
        username: 'whiskers_adventures',
        caption: 'Translated: “Where’s my dinner, human?” 😹 #CatTranslation',
        likes: 521,
        comments: 78,
      ),
    ];
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
    _initializeVideo(index);
  }

  Future<void> _initializeVideo(int index) async {
    final videoUrl = reels[index].videoUrl;
    videoController?.dispose();
    videoController = VideoPlayerController.network(videoUrl);

    try {
      await videoController?.initialize();
      videoController?.play();
      videoController?.setLooping(true);
      update();
    } catch (e) {
      print('Error initializing video: $e');
    }
  }

  void toggleLike(String reelId) {
    final index = reels.indexWhere((reel) => reel.id == reelId);
    if (index != -1) {
      final reel = reels[index];
      final newReel = ReelItem(
        id: reel.id,
        videoUrl: reel.videoUrl,
        userAvatarUrl: reel.userAvatarUrl,
        username: reel.username,
        caption: reel.caption,
        likes: reel.isLiked ? reel.likes - 1 : reel.likes + 1,
        comments: reel.comments,
        isLiked: !reel.isLiked,
        isSaved: reel.isSaved,
      );
      reels[index] = newReel;
    }
  }

  void toggleSave(String reelId) {
    final index = reels.indexWhere((reel) => reel.id == reelId);
    if (index != -1) {
      final reel = reels[index];
      final newReel = ReelItem(
        id: reel.id,
        videoUrl: reel.videoUrl,
        userAvatarUrl: reel.userAvatarUrl,
        username: reel.username,
        caption: reel.caption,
        likes: reel.likes,
        comments: reel.comments,
        isLiked: reel.isLiked,
        isSaved: !reel.isSaved,
      );
      reels[index] = newReel;

      Get.snackbar(
        newReel.isSaved ? 'Saved' : 'Removed',
        newReel.isSaved
            ? 'Reel saved to your collection'
            : 'Reel removed from your collection',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void shareReel(String reelId) {
    Get.snackbar(
      'Share',
      'Sharing options opened',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void showComments(String reelId) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'Comments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text('Comments coming soon!'),
            ),
          ],
        ),
      ),
    );
  }
}
