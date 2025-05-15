import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petspeak_ai/app/modules/translations_history/controllers/translations_history_controller.dart';
import 'package:petspeak_ai/app/utils/constants/app_colors.dart';
import 'package:petspeak_ai/global_widgets/translation_card.dart';

class TranslationsHistoryView extends GetView<TranslationsHistoryController> {
  const TranslationsHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translation History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
            tooltip: 'Search translations',
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
            tooltip: 'Filter translations',
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.filteredTranslations.isEmpty) {
          return _buildEmptyState(context);
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 24),
          physics: const BouncingScrollPhysics(),
          itemCount: controller.filteredTranslations.length,
          itemBuilder: (context, index) {
            final translation = controller.filteredTranslations[index];
            return TranslationCard(
              translation: translation,
              onPlayAudio: () => controller.playAudio(translation),
              onShare: () => controller.shareTranslation(translation),
              onToggleFavorite: () => controller.toggleFavorite(translation),
              onTap: () => _showTranslationDetails(context, translation),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.navigateToTranslations,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No translations yet',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Your translation history will appear here',
            style: TextStyle(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: controller.navigateToTranslations,
            icon: const Icon(Icons.translate),
            label: const Text('Start Translating'),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Search Translations'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter search term',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: controller.searchTranslations,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                controller.clearSearch();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }

  void _showFilterDialog(BuildContext context) {
    final RxString selectedPetType = controller.filter.petType.obs;
    final RxString selectedMode = controller.filter.mode.obs;
    final RxBool favoritesOnly = controller.filter.favoritesOnly.obs;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter Translations'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Pet Type',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Obx(() => Row(
                    children: [
                      Radio<String>(
                        value: 'all',
                        groupValue: selectedPetType.value,
                        onChanged: (value) => selectedPetType.value = value!,
                        activeColor: AppColors.primary,
                      ),
                      const Text('All'),
                      Radio<String>(
                        value: 'dog',
                        groupValue: selectedPetType.value,
                        onChanged: (value) => selectedPetType.value = value!,
                        activeColor: AppColors.dogMode,
                      ),
                      const Text('Dog'),
                      Radio<String>(
                        value: 'cat',
                        groupValue: selectedPetType.value,
                        onChanged: (value) => selectedPetType.value = value!,
                        activeColor: AppColors.catMode,
                      ),
                      const Text('Cat'),
                    ],
                  )),
              const SizedBox(height: 16),
              const Text('Translation Mode',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Obx(() => Row(
                    children: [
                      Radio<String>(
                        value: 'all',
                        groupValue: selectedMode.value,
                        onChanged: (value) => selectedMode.value = value!,
                        activeColor: AppColors.primary,
                      ),
                      const Text('All'),
                      Radio<String>(
                        value: 'pet-to-human',
                        groupValue: selectedMode.value,
                        onChanged: (value) => selectedMode.value = value!,
                        activeColor: AppColors.primary,
                      ),
                      const Expanded(child: Text('Pet to Human')),
                    ],
                  )),
              Obx(() => Row(
                    children: [
                      Radio<String>(
                        value: 'human-to-pet',
                        groupValue: selectedMode.value,
                        onChanged: (value) => selectedMode.value = value!,
                        activeColor: AppColors.primary,
                      ),
                      const Expanded(child: Text('Human to Pet')),
                    ],
                  )),
              const SizedBox(height: 16),
              Obx(() => Row(
                    children: [
                      Checkbox(
                        value: favoritesOnly.value,
                        onChanged: (value) => favoritesOnly.value = value!,
                        activeColor: AppColors.primary,
                      ),
                      const Text('Favorites only'),
                    ],
                  )),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                controller.clearFilters();
              },
              child: const Text('Clear Filters'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                controller.applyFilters(
                  petType: selectedPetType.value,
                  mode: selectedMode.value,
                  favoritesOnly: favoritesOnly.value,
                );
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  void _showTranslationDetails(BuildContext context, dynamic translation) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Title
              Text(
                'Translation Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: 20),

              // Translation card
              Expanded(
                child: TranslationCard(
                  translation: translation,
                  onPlayAudio: () => controller.playAudio(translation),
                  onShare: () => controller.shareTranslation(translation),
                  onToggleFavorite: () =>
                      controller.toggleFavorite(translation),
                  isDetailed: true,
                ),
              ),

              const SizedBox(height: 20),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      controller.deleteTranslation(translation);
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      controller.shareTranslation(translation);
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
