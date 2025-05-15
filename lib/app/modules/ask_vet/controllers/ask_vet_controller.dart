import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petspeak_ai/app/common/utils/util.dart';
import 'package:petspeak_ai/app/routes/app_routes.dart';

class AskVetController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeChat();
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void _initializeChat() {
    messages.add({
      'isUser': false,
      'text':
          'Hello! I\'m Dr. Chloe, your AI veterinary assistant. How can I help you and your pet today?',
      'timestamp': _getCurrentTime(),
    });

    messages.add({
      'isUser': false,
      'text':
          'You can ask me about pet health, behavior, nutrition, or any other concerns you might have.',
      'timestamp': _getCurrentTime(),
    });
  }

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    // Add user message
    messages.add({
      'isUser': true,
      'text': text,
      'timestamp': _getCurrentTime(),
    });

    // Clear input field
    textController.clear();

    // Scroll to bottom
    _scrollToBottom();

    // Simulate processing delay
    Future.delayed(const Duration(milliseconds: 500), () {
      // Add typing indicator
      messages.add({
        'isUser': false,
        'text': 'Typing...',
        'isTyping': true,
      });

      // Scroll to bottom
      _scrollToBottom();

      // Simulate AI response delay
      Future.delayed(const Duration(seconds: 1), () {
        // Remove typing indicator
        messages.removeWhere((message) => message['isTyping'] == true);

        // Add AI response
        final response = _generateResponse(text);
        messages.add({
          'isUser': false,
          'text': response,
          'timestamp': _getCurrentTime(),
        });

        // Scroll to bottom
        _scrollToBottom();
      });
    });
  }

  void pickImage() {
    snackbar(
        'Upload Photo',
        'Photo upload functionality will be available soon!',
        SnackPosition.BOTTOM);
    // In a real app, this would open image picker
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  String _generateResponse(String query) {
    // Simple pattern matching for demo purposes
    final lowerQuery = query.toLowerCase();

    if (lowerQuery.contains('diet') ||
        lowerQuery.contains('food') ||
        lowerQuery.contains('eat')) {
      return 'A balanced diet is crucial for your pet\'s health. For dogs and cats, high-quality commercial pet food that meets AAFCO standards is generally recommended. The specific amount depends on your pet\'s age, weight, and activity level. Always provide fresh water, and limit treats to 10% of their daily caloric intake. Would you like more specific recommendations for your pet?';
    }

    if (lowerQuery.contains('vomit') ||
        lowerQuery.contains('diarrhea') ||
        lowerQuery.contains('sick')) {
      return 'I\'m sorry to hear your pet isn\'t feeling well. Occasional vomiting or diarrhea can be caused by dietary indiscretion, but if it persists for more than 24 hours, is accompanied by lethargy, or contains blood, you should contact your veterinarian immediately. In the meantime, withhold food for 12 hours (but provide water) and then introduce a bland diet like boiled chicken and rice in small amounts.';
    }

    if (lowerQuery.contains('flea') ||
        lowerQuery.contains('tick') ||
        lowerQuery.contains('parasite')) {
      return 'Fleas and ticks can cause discomfort and transmit diseases. I recommend year-round prevention with veterinarian-approved products. Many options are available including topical treatments, oral medications, and collars. It\'s important to treat all pets in the household and the environment as well. Regular checks during grooming can help catch infestations early.';
    }

    if (lowerQuery.contains('vaccine') ||
        lowerQuery.contains('vaccination') ||
        lowerQuery.contains('shot')) {
      return 'Vaccines are essential for preventing serious diseases. Core vaccines for dogs include rabies, distemper, parvovirus, and adenovirus. For cats, rabies, feline viral rhinotracheitis, calicivirus, and panleukopenia are recommended. The vaccination schedule starts when pets are young and requires boosters throughout their life. Your local veterinarian can provide a schedule tailored to your pet\'s lifestyle and risk factors.';
    }

    if (lowerQuery.contains('bark') ||
        lowerQuery.contains('meow') ||
        lowerQuery.contains('behavior')) {
      return 'Behavioral issues can stem from various factors including inadequate exercise, boredom, anxiety, or medical problems. Consistent positive reinforcement training, regular exercise, and mental stimulation are key for managing behavior. If there\'s a sudden change in behavior, it could indicate a health issue, so a veterinary check-up would be recommended. Would you like specific tips for a particular behavior?';
    }

    // Default response
    return 'Thank you for your question about ${query.split(' ').take(3).join(' ')}... For the most accurate advice tailored to your specific pet, I\'d recommend consulting with your local veterinarian. They can provide personalized guidance based on your pet\'s individual health history and needs. Is there anything else I can help with?';
  }

  // Navigation methods
  void onNavItemTapped(int index) {
    switch (index) {
      case 0: // Home
        Get.offAllNamed(Routes.HOME);
        break;
      case 1: // Translate
        Get.offAllNamed(Routes.TRANSLATIONS);
        break;
      case 2: // Reels
        Get.offAllNamed(Routes.REELS);
        break;
      case 3: // Ask Vet - already here
        break;
      case 4: // Profile
        Get.offAllNamed(Routes.PET_PROFILE);
        break;
    }
  }

  void navigateToSubscription() {
    Get.toNamed(Routes.SUBSCRIPTION);
  }
}
