import 'package:flutter/material.dart';
import 'package:petspeak_ai/app/data/models/translation_model.dart';
import 'package:petspeak_ai/app/utils/constants/app_colors.dart';

class TranslationCard extends StatelessWidget {
  final TranslationModel translation;
  final VoidCallback? onPlayAudio;
  final VoidCallback? onShare;
  final VoidCallback? onToggleFavorite;
  final VoidCallback? onTap;
  final bool isDetailed;

  const TranslationCard({
    super.key,
    required this.translation,
    this.onPlayAudio,
    this.onShare,
    this.onToggleFavorite,
    this.onTap,
    this.isDetailed = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color cardColor = translation.petType == 'dog'
        ? AppColors.dogMode.withOpacity(0.1)
        : AppColors.catMode.withOpacity(0.1);

    final Color accentColor =
        translation.petType == 'dog' ? AppColors.dogMode : AppColors.catMode;

    final bool hasPetToHuman = translation.mode == 'pet-to-human';

    // Format date as "Jun 15, 2023" or "Today at 3:45 PM" if today
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime translationDate = DateTime(translation.createdAt.year,
        translation.createdAt.month, translation.createdAt.day);

    final String dateText = translationDate == today
        ? 'Today at ${translation.createdAt.hour}:${translation.createdAt.minute.toString().padLeft(2, '0')}'
        : '${_getMonthAbbreviation(translation.createdAt.month)} ${translation.createdAt.day}, ${translation.createdAt.year}';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with mode and timestamp
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Mode icon and text
                  Row(
                    children: [
                      Icon(
                        hasPetToHuman ? Icons.pets : Icons.record_voice_over,
                        color: accentColor,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        hasPetToHuman ? 'Pet to Human' : 'Human to Pet',
                        style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      if (translation.petType == 'dog')
                        const Icon(Icons.emoji_nature, size: 16)
                      else
                        const Icon(Icons.catching_pokemon, size: 16),
                    ],
                  ),

                  // Date
                  Text(
                    dateText,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Translation content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Original text
                  Text(
                    hasPetToHuman ? 'Original Sound' : 'You said:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    translation.originalText,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Translated text
                  Text(
                    hasPetToHuman ? 'Translation' : 'Your pet hears:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    translation.translatedText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: accentColor,
                    ),
                  ),

                  // Additional details if detailed view
                  if (isDetailed) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.language, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Language: ${translation.language}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Actions
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Play audio button
                  if (translation.audioPath != null)
                    IconButton(
                      onPressed: onPlayAudio,
                      icon: const Icon(Icons.play_circle_outline),
                      tooltip: 'Play Audio',
                    ),

                  // Share button
                  IconButton(
                    onPressed: onShare,
                    icon: const Icon(Icons.share_outlined),
                    tooltip: 'Share',
                  ),

                  // Favorite button
                  IconButton(
                    onPressed: onToggleFavorite,
                    icon: Icon(
                      translation.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: translation.isFavorite ? Colors.red : null,
                    ),
                    tooltip: 'Favorite',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthAbbreviation(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
