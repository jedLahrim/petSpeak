import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  late final GetStorage _box;

  Future<StorageService> init() async {
    _box = GetStorage();
    return this;
  }

  // Generic get method with default value
  T read<T>(String key, {required T defaultValue}) {
    return _box.read<T>(key) ?? defaultValue;
  }

  // Generic write method
  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  // Check if key exists
  bool hasData(String key) {
    return _box.hasData(key);
  }

  // Remove a key
  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  // Clear all data
  Future<void> clearAll() async {
    await _box.erase();
  }

  // App specific storage methods
  bool get isFirstLaunch => read<bool>('isFirstLaunch', defaultValue: true);

  set isFirstLaunch(bool value) => write('isFirstLaunch', value);

  bool get isDarkMode => read<bool>('isDarkMode', defaultValue: false);

  set isDarkMode(bool value) => write('isDarkMode', value);

  String? get authToken => read<String?>('authToken', defaultValue: null);

  set authToken(String? value) => write('authToken', value);

  Map<String, dynamic>? get currentUser =>
      read<Map<String, dynamic>?>('currentUser', defaultValue: null);

  set currentUser(Map<String, dynamic>? value) => write('currentUser', value);

  List<Map<String, dynamic>> get savedPets {
    final List<dynamic> rawList =
        read<List<dynamic>>('savedPets', defaultValue: []);
    return List<Map<String, dynamic>>.from(rawList);
  }

  set savedPets(List<Map<String, dynamic>> value) => write('savedPets', value);

  String get selectedLanguage =>
      read<String>('selectedLanguage', defaultValue: 'en');

  set selectedLanguage(String value) => write('selectedLanguage', value);

  String get selectedMode => read<String>('selectedMode', defaultValue: 'dog');

  set selectedMode(String value) => write('selectedMode', value);

  bool get isPremium => read<bool>('isPremium', defaultValue: false);

  set isPremium(bool value) => write('isPremium', value);

  String? get subscriptionTier =>
      read<String?>('subscriptionTier', defaultValue: null);

  set subscriptionTier(String? value) => write('subscriptionTier', value);

  DateTime? get subscriptionExpiryDate {
    final timestamp = read<int?>('subscriptionExpiryDate', defaultValue: null);
    return timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timestamp)
        : null;
  }

  set subscriptionExpiryDate(DateTime? value) {
    final timestamp = value?.millisecondsSinceEpoch;
    write('subscriptionExpiryDate', timestamp);
  }
}
