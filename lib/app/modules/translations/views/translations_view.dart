import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petspeak_ai/app/modules/translations/controllers/translations_controller.dart';
import 'package:petspeak_ai/app/utils/constants/app_colors.dart';
import 'package:petspeak_ai/global_widgets/audio_waveform_widget.dart';
import 'package:petspeak_ai/global_widgets/custom_bottom_nav_bar.dart';
import 'package:petspeak_ai/global_widgets/pet_speak_button.dart';

class TranslationsView extends GetView<TranslationsController> {
  const TranslationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translate'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: controller.navigateToHistory,
            tooltip: 'Translation History',
          ),
        ],
      ),
      body: Obx(
        () {
          return SafeArea(
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Column(
                children: [
                  // Mode Toggle
                  _buildModeToggle(context),

                  // Pet Type Toggle
                  _buildPetTypeToggle(context),

                  // Language Selection
                  _buildLanguageSelection(context),

                  // Translation Area
                  _buildTranslationArea(context),

                  // Recording Area with fixed height to ensure it's always visible
                  SizedBox(
                    child: _buildRecordingArea(context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: controller.onNavItemTapped,
      ),
    );
  }

  Widget _buildModeToggle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          // Pet to Human Mode
          Expanded(
            child: GestureDetector(
              onTap: () => controller.setMode('pet-to-human'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: controller.mode.value == 'pet-to-human'
                      ? AppColors.primary
                      : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.pets,
                      size: 20,
                      color: controller.mode.value == 'pet-to-human'
                          ? Colors.white
                          : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Pet to Human',
                      style: TextStyle(
                        color: controller.mode.value == 'pet-to-human'
                            ? Colors.white
                            : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Human to Pet Mode
          Expanded(
            child: GestureDetector(
              onTap: () => controller.setMode('human-to-pet'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: controller.mode.value == 'human-to-pet'
                      ? AppColors.primary
                      : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.record_voice_over,
                      size: 20,
                      color: controller.mode.value == 'human-to-pet'
                          ? Colors.white
                          : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Human to Pet',
                      style: TextStyle(
                        color: controller.mode.value == 'human-to-pet'
                            ? Colors.white
                            : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetTypeToggle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Dog Mode
          Expanded(
            child: GestureDetector(
              onTap: () => controller.setPetType('dog'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: controller.petType.value == 'dog'
                      ? AppColors.dogMode.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: controller.petType.value == 'dog'
                        ? AppColors.dogMode
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.pets,
                      size: 20,
                      color: controller.petType.value == 'dog'
                          ? AppColors.dogMode
                          : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Dog',
                      style: TextStyle(
                        color: controller.petType.value == 'dog'
                            ? AppColors.dogMode
                            : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Cat Mode
          Expanded(
            child: GestureDetector(
              onTap: () => controller.setPetType('cat'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: controller.petType.value == 'cat'
                      ? AppColors.catMode.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: controller.petType.value == 'cat'
                        ? AppColors.catMode
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.emoji_nature,
                      size: 20,
                      color: controller.petType.value == 'cat'
                          ? AppColors.catMode
                          : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Cat',
                      style: TextStyle(
                        color: controller.petType.value == 'cat'
                            ? AppColors.catMode
                            : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
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
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: controller.language.value,
          isExpanded: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          borderRadius: BorderRadius.circular(12),
          icon: const Icon(Icons.arrow_drop_down),
          items: controller.languages.map((language) {
            return DropdownMenuItem<String>(
              value: language['code'],
              child: Row(
                children: [
                  Text(language['flag']),
                  const SizedBox(width: 8),
                  Text(language['name']),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              controller.setLanguage(value);
            }
          },
        ),
      ),
    );
  }

  Widget _buildTranslationArea(BuildContext context) {
    return GetBuilder<TranslationsController>(
      builder: (controller) {
        // Trigger scroll after UI updates
        if (controller.shouldScroll) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.scrollToBottom(controller.scrollController);
            controller.resetScroll(); // Reset flag after scrolling
          });
        }
        final bool showResult = controller.translationResult.value.isNotEmpty;
        final bool isPetToHuman = controller.mode.value == 'pet-to-human';

        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(16),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Original text label
              Text(
                isPetToHuman ? 'Original Sound' : 'You said:',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 8),

              // Original text or placeholder
              Text(
                showResult
                    ? controller.originalText.value
                    : isPetToHuman
                        ? 'Tap the button below to record your pet\'s sound...'
                        : 'Tap the button below to record your message...',
                style: TextStyle(
                  fontSize: 16,
                  color: showResult ? null : Colors.grey,
                ),
              ),

              if (showResult) ...[
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),

                // Translation label
                Text(
                  isPetToHuman ? 'Translation' : 'Your pet hears:',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 8),

                // Translation result
                Text(
                  controller.translationResult.value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: controller.petType.value == 'dog'
                        ? AppColors.dogMode
                        : AppColors.catMode,
                  ),
                ),

                const SizedBox(height: 24),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      context,
                      'Replay',
                      Icons.replay,
                      controller.replayAudio,
                    ),
                    _buildActionButton(
                      context,
                      'Save',
                      Icons.save,
                      controller.saveTranslation,
                    ),
                    _buildActionButton(
                      context,
                      'Share',
                      Icons.share,
                      controller.shareTranslation,
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(icon),
          color: AppColors.primary,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildRecordingArea(BuildContext context) {
    final Color buttonColor = controller.petType.value == 'dog'
        ? AppColors.dogMode
        : AppColors.catMode;

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Audio waveform visualization
          AudioWaveformWidget(
            isActive: controller.isRecording.value,
            activeColor: buttonColor,
            height: 60,
          ),

          // const SizedBox(height: 24),

          // Recording status text
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              controller.isRecording.value
                  ? controller.mode.value == 'pet-to-human'
                      ? 'Listening to your pet...'
                      : 'Recording your message...'
                  : controller.translationResult.value.isNotEmpty
                      ? 'Tap to record a new message'
                      : 'Tap to start recording',
              key: ValueKey<bool>(controller.isRecording.value),
              style: TextStyle(
                fontSize: 16,
                color: controller.isRecording.value
                    ? buttonColor
                    : Colors.grey[600],
              ),
            ),
          ),

          const SizedBox(height: 100),

          // Record button
          MicrophoneButton(
            isRecording: controller.isRecording.value,
            onTap: controller.toggleRecording,
            petType: controller.petType.value,
            size: 80,
            color: buttonColor,
          ),
        ],
      ),
    );
  }
}
