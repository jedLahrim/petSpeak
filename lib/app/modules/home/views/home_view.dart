import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petspeak_ai/app/common/icons/reels_icon.dart';
import 'package:petspeak_ai/app/data/models/pet_model.dart';
import 'package:petspeak_ai/app/modules/home/controllers/home_controller.dart';
import 'package:petspeak_ai/app/utils/constants/app_colors.dart';
import 'package:petspeak_ai/global_widgets/custom_bottom_nav_bar.dart';
import 'package:petspeak_ai/global_widgets/pet_avatar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: controller.selectedPetIndex.value,
          children: controller.pets
              .map((pet) => _buildPetHomePage(context, pet))
              .toList(),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: controller.onNavItemTapped,
      ),
    );
  }

  Widget _buildPetHomePage(BuildContext context, PetModel pet) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Bar
          _buildAppBar(context),

          const SizedBox(height: 16),

          // Welcome Message
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Hello, ${pet.name}\'s human!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'What would you like to do today?',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Quick Actions
          _buildQuickActions(context),

          const SizedBox(height: 24),

          // Translations History Section
          _buildSectionHeader(
            context,
            'Recent Translations',
            'View All',
            onTap: () => controller.navigateToTranslationsHistory(),
          ),

          _buildRecentTranslations(context),

          const SizedBox(height: 24),

          // Pet Health Tips
          _buildSectionHeader(
            context,
            'Health Tips',
            'More Tips',
            onTap: () => controller.navigateToHealthTips(),
          ),

          _buildHealthTips(context),

          const SizedBox(height: 24),

          // Pet Community
          _buildSectionHeader(
            context,
            'Pet Community',
            'View All',
            onTap: () => controller.navigateToReels(),
          ),

          _buildCommunityCards(context),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title and logo
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.pets,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'PetSpeak AI',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Pet selector
          _buildPetSelector(context),
        ],
      ),
    );
  }

  Widget _buildPetSelector(BuildContext context) {
    final selectedPet = controller.pets[controller.selectedPetIndex.value];
    return GestureDetector(
      onTap: () => _showPetSelectorModal(context),
      child: Row(
        children: [
          PetAvatar(
            imageUrl: selectedPet.profileImageUrl,
            petType: selectedPet.type,
            size: 40,
          ),
          const SizedBox(width: 8),
          Text(
            selectedPet.name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  void _showPetSelectorModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Pet',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ...controller.pets.asMap().entries.map((entry) {
                final index = entry.key;
                final pet = entry.value;

                return ListTile(
                  leading: PetAvatar(
                    imageUrl: pet.profileImageUrl,
                    petType: pet.type,
                    size: 40,
                  ),
                  title: Text(pet.name),
                  subtitle: Text(pet.breed ?? ''),
                  trailing: Obx(() => controller.selectedPetIndex.value == index
                      ? const Icon(Icons.check_circle, color: AppColors.primary)
                      : const SizedBox.shrink()),
                  onTap: () {
                    controller.selectedPetIndex.value = index;
                    Navigator.pop(context);
                  },
                );
              }).toList(),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller.navigateToPetProfile();
                },
                child: const Text('Add New Pet'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _buildActionCard(
            context,
            'Translate',
            Icons.translate,
            AppColors.primary,
            () => controller.navigateToTranslations(),
          ),
          _buildActionCard(
            context,
            'Ask Vet',
            Icons.medical_services,
            AppColors.secondary,
            () => controller.navigateToAskVet(),
          ),
          _buildActionCard(
            context,
            'Pet Reels',
            ReelIcon.reels,
            AppColors.accent,
            () => controller.navigateToReels(),
          ),
          _buildActionCard(
            context,
            'Profile',
            Icons.person,
            Colors.amber,
            () => controller.navigateToPetProfile(),
          ),
          _buildActionCard(
            context,
            'Upgrade',
            Icons.star,
            Colors.purple,
            () => controller.navigateToSubscription(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, String title, IconData icon,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.solid,
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, String actionText,
      {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              actionText,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTranslations(BuildContext context) {
    if (controller.recentTranslations.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.solid,
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.translate,
                    size: 48,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No translations yet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Start translating what your pet is trying to tell you!',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => controller.navigateToTranslations(),
                    child: const Text('Translate Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: 150,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.recentTranslations.length,
        itemBuilder: (context, index) {
          final translation = controller.recentTranslations[index];
          return Container(
            width: 280,
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.solid,
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      translation.mode == 'pet-to-human'
                          ? Icons.pets
                          : Icons.record_voice_over,
                      color: translation.petType == 'dog'
                          ? AppColors.dogMode
                          : AppColors.catMode,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      translation.mode == 'pet-to-human'
                          ? 'Pet to Human'
                          : 'Human to Pet',
                      style: TextStyle(
                        color: translation.petType == 'dog'
                            ? AppColors.dogMode
                            : AppColors.catMode,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      controller.getFriendlyDate(translation.createdAt),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Text(
                    translation.translatedText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.play_circle_outline, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 16),
                    translation.isFavorite
                        ? IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite,
                              size: 20,
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          )
                        : IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_border, size: 20),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.share_outlined, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHealthTips(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.healthTips.length,
        itemBuilder: (context, index) {
          final tip = controller.healthTips[index];
          return Container(
            width: 250,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(tip['imageUrl']),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.solid,
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      tip['category'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tip['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'by Dr. ${tip['author']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCommunityCards(BuildContext context) {
    return SizedBox(
      height: 280, // Increased height to accommodate content
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.communityPosts.length,
        itemBuilder: (context, index) {
          final post = controller.communityPosts[index];
          return Container(
            width: 200, // Increased width
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.solid,
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Post image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    post['imageUrl'],
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Caption
                        Text(
                          post['caption'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),

                        // User info
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundImage:
                                  NetworkImage(post['userAvatarUrl']),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                post['username'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        // Engagement stats
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              post['likes'].toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Icon(
                              Icons.chat_bubble_outline,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              post['comments'].toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
