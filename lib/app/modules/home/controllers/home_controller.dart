import 'package:get/get.dart';
import 'package:petspeak_ai/app/routes/app_routes.dart';

class HomeController extends GetxController {
  final RxInt selectedPetIndex = 0.obs;

  // Mock data - would come from API in real app
  final List<Map<String, dynamic>> pets = [
    {
      'id': '1',
      'name': 'Buddy',
      'type': 'dog',
      'breed': 'Golden Retriever',
      'birthDate': '2020-04-15',
      'gender': 'male',
      'weight': 28.5,
      'profileImageUrl':
          'https://images.pexels.com/photos/2253275/pexels-photo-2253275.jpeg?auto=compress&cs=tinysrgb&w=300',
    },
    {
      'id': '2',
      'name': 'Luna',
      'type': 'cat',
      'breed': 'Siamese',
      'birthDate': '2021-01-10',
      'gender': 'female',
      'weight': 4.2,
      'profileImageUrl':
          'https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg?auto=compress&cs=tinysrgb&w=300',
    },
  ];

  final List<Map<String, dynamic>> recentTranslations = [
    {
      'id': '1',
      'petId': '1',
      'mode': 'pet-to-human',
      'petType': 'dog',
      'originalText': 'Woof woof!',
      'translatedText': 'I\'m really excited to go for a walk!',
      'date': 'Today',
      'isFavorite': true,
    },
    {
      'id': '2',
      'petId': '1',
      'mode': 'human-to-pet',
      'petType': 'dog',
      'originalText': 'Do you want a treat?',
      'translatedText': 'Bark bark! (Yes, I would love one!)',
      'date': 'Yesterday',
      'isFavorite': false,
    },
    {
      'id': '3',
      'petId': '2',
      'mode': 'pet-to-human',
      'petType': 'cat',
      'originalText': 'Meow meow',
      'translatedText': 'My food bowl is empty, please fill it now!',
      'date': 'Yesterday',
      'isFavorite': false,
    },
  ];

  final List<Map<String, dynamic>> healthTips = [
    {
      'id': '1',
      'title': '5 Signs Your Dog Needs More Exercise',
      'category': 'Wellness',
      'author': 'Smith',
      'imageUrl':
          'https://images.pexels.com/photos/1254140/pexels-photo-1254140.jpeg?auto=compress&cs=tinysrgb&w=300',
    },
    {
      'id': '2',
      'title': 'Understanding Your Cat\'s Body Language',
      'category': 'Behavior',
      'author': 'Johnson',
      'imageUrl':
          'https://images.pexels.com/photos/96938/pexels-photo-96938.jpeg?auto=compress&cs=tinysrgb&w=300',
    },
    {
      'id': '3',
      'title': 'Healthy Treats for Dogs with Allergies',
      'category': 'Nutrition',
      'author': 'Williams',
      'imageUrl':
          'https://images.pexels.com/photos/3361739/pexels-photo-3361739.jpeg?auto=compress&cs=tinysrgb&w=300',
    },
  ];

  final List<Map<String, dynamic>> communityPosts = [
    {
      'id': '1',
      'username': 'max_and_bella',
      'userAvatarUrl':
          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=300',
      'caption': 'Max just told me he loves the beach! 🐾🌊',
      'imageUrl':
          'https://images.pexels.com/photos/1959055/pexels-photo-1959055.jpeg?auto=compress&cs=tinysrgb&w=300',
      'likes': 342,
      'comments': 42,
    },
    {
      'id': '2',
      'username': 'whiskers_adventures',
      'userAvatarUrl':
          'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=300',
      'caption': 'Translated: "Where\'s my dinner, human?"',
      'imageUrl':
          'https://images.pexels.com/photos/2061057/pexels-photo-2061057.jpeg?auto=compress&cs=tinysrgb&w=300',
      'likes': 521,
      'comments': 78,
    },
    {
      'id': '3',
      'username': 'doggo_daily',
      'userAvatarUrl':
          'https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=300',
      'caption': 'Luna says she wants more treats! 🦴',
      'imageUrl':
          'https://images.pexels.com/photos/2797318/pexels-photo-2797318.jpeg?auto=compress&cs=tinysrgb&w=300',
      'likes': 287,
      'comments': 36,
    },
  ];

  // Navigation methods
  void onNavItemTapped(int index) {
    switch (index) {
      case 0: // Home - already here
        break;
      case 1: // Translate
        navigateToTranslations();
        break;
      case 2: // Reels
        navigateToReels();
        break;
      case 3: // Ask Vet
        navigateToAskVet();
        break;
      case 4: // Profile
        navigateToPetProfile();
        break;
    }
  }

  void navigateToTranslations() {
    Get.toNamed(Routes.TRANSLATIONS);
  }

  void navigateToTranslationsHistory() {
    Get.toNamed(Routes.TRANSLATIONS_HISTORY);
  }

  void navigateToAskVet() {
    Get.toNamed(Routes.ASK_VET);
  }

  void navigateToPetProfile() {
    Get.toNamed(Routes.PET_PROFILE);
  }

  void navigateToReels() {
    Get.toNamed(Routes.REELS);
  }

  void navigateToSubscription() {
    Get.toNamed(Routes.SUBSCRIPTION);
  }

  void navigateToHealthTips() {
    // This would be implemented in a real app
    Get.snackbar(
      'Coming Soon',
      'Health tips section will be available in the next update!',
    );
  }
}
