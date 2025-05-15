import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petspeak_ai/app/modules/pet_profile/controllers/pet_profile_controller.dart';
import 'package:petspeak_ai/app/utils/constants/app_colors.dart';
import 'package:petspeak_ai/global_widgets/custom_bottom_nav_bar.dart';
import 'package:petspeak_ai/global_widgets/pet_avatar.dart';

import '../../../routes/app_routes.dart';
import '../controllers/theme_controller.dart';

class PetProfileView extends GetView<PetProfileController> {
  const PetProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Profile'),
        actions: [
          Obx(() => IconButton(
                icon: Icon(
                  themeController.isDarkMode.value
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: themeController.toggleTheme,
              )),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddPetDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Add logout logic here
              // using GetX for navigation:
              Get.toNamed(Routes.LOGIN);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.pets.isEmpty) {
          return _buildEmptyState(context);
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              // Pet selector
              _buildPetSelector(context),

              // Pet details
              _buildPetDetails(context),
            ],
          ),
        );
      }),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 4,
        onTap: (index) {
          // Navigation handled by CustomBottomNavBar
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.pets,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No pets added yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first pet to get started',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _showAddPetDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('Add Pet'),
          ),
        ],
      ),
    );
  }

  Widget _buildPetSelector(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.pets.length + 1,
        itemBuilder: (context, index) {
          if (index == controller.pets.length) {
            return _buildAddPetButton(context);
          }

          final pet = controller.pets[index];
          final isSelected = controller.selectedPetIndex.value == index;

          return GestureDetector(
            onTap: () => controller.selectPet(index),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: Column(
                children: [
                  PetAvatar(
                    imageUrl: pet.profileImageUrl,
                    petType: pet.type,
                    size: 60,
                    showBorder: isSelected,
                    borderColor: isSelected ? AppColors.primary : null,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pet.name,
                    style: TextStyle(
                      color: isSelected ? AppColors.primary : null,
                      fontWeight: isSelected ? FontWeight.bold : null,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddPetButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAddPetDialog(context),
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.add,
                color: Colors.grey[400],
                size: 30,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Add Pet',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetDetails(BuildContext context) {
    final pet = controller.pets[controller.selectedPetIndex.value];

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile header
          Row(
            children: [
              Stack(
                children: [
                  PetAvatar(
                    imageUrl: pet.profileImageUrl,
                    petType: pet.type,
                    size: 100,
                    onTap: controller.pickImage,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      pet.breed ?? 'Unknown breed',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          pet.type == 'dog' ? Icons.pets : Icons.emoji_nature,
                          size: 16,
                          color: pet.type == 'dog'
                              ? AppColors.dogMode
                              : AppColors.catMode,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          pet.type.capitalizeFirst!,
                          style: TextStyle(
                            color: pet.type == 'dog'
                                ? AppColors.dogMode
                                : AppColors.catMode,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Pet info cards
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  context,
                  'Age',
                  pet.age,
                  Icons.cake,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInfoCard(
                  context,
                  'Weight',
                  '${pet.weight?.toStringAsFixed(1) ?? 'Unknown'} kg',
                  Icons.monitor_weight,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInfoCard(
                  context,
                  'Gender',
                  pet.gender?.capitalizeFirst ?? 'Unknown',
                  pet.gender == 'male' ? Icons.male : Icons.female,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Health records
          _buildHealthRecords(context),

          const SizedBox(height: 24),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: controller.deletePet,
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete Profile'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showEditPetDialog(context, pet),
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profile'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.solid,
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthRecords(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Health Records',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: controller.navigateToSubscription,
              child: const Text('Upgrade to Premium'),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.amber,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.lock,
                color: Colors.amber,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Premium Feature',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Upgrade to premium to access health records, vaccination tracking, and vet visit history.',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAddPetDialog(BuildContext context) {
    controller.nameController.clear();
    controller.breedController.clear();
    controller.weightController.clear();
    controller.petType.value = 'dog';
    controller.birthDate.value = null;
    controller.gender.value = 'male';
    controller.profileImageUrl?.value = '';

    Get.dialog(
      Dialog(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add New Pet',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  labelText: 'Pet Name',
                  prefixIcon: Icon(Icons.pets),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Obx(() => DropdownButtonFormField<String>(
                          value: controller.petType.value,
                          decoration: const InputDecoration(
                            labelText: 'Pet Type',
                            prefixIcon: Icon(Icons.category),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'dog',
                              child: Text('Dog'),
                            ),
                            DropdownMenuItem(
                              value: 'cat',
                              child: Text('Cat'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              controller.updatePetType(value);
                            }
                          },
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.breedController,
                decoration: const InputDecoration(
                  labelText: 'Breed',
                  prefixIcon: Icon(Icons.pets),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Obx(() => DropdownButtonFormField<String>(
                          value: controller.gender.value,
                          decoration: const InputDecoration(
                            labelText: 'Gender',
                            prefixIcon: Icon(Icons.transgender),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'male',
                              child: Text('Male'),
                            ),
                            DropdownMenuItem(
                              value: 'female',
                              child: Text('Female'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              controller.updateGender(value);
                            }
                          },
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: controller.selectBirthDate,
                child: AbsorbPointer(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Birth Date',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(
                      text: controller.birthDate.value != null
                          ? '${controller.birthDate.value!.day}/${controller.birthDate.value!.month}/${controller.birthDate.value!.year}'
                          : '',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Weight (kg)',
                  prefixIcon: Icon(Icons.monitor_weight),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: controller.savePet,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditPetDialog(BuildContext context, dynamic pet) {
    controller.nameController.text = pet.name;
    controller.breedController.text = pet.breed ?? '';
    controller.weightController.text = pet.weight?.toString() ?? '';
    controller.petType.value = pet.type;
    controller.birthDate.value = pet.birthDate;
    controller.gender.value = pet.gender ?? 'male';
    controller.profileImageUrl?.value = pet.profileImageUrl;

    _showAddPetDialog(context);
  }
}
