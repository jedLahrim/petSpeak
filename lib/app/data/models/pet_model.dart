import 'package:get/get.dart';

class PetModel {
  final String id;
  final String name;
  final String type; // 'dog' or 'cat'
  final String? breed;
  final DateTime? birthDate;
  final String? gender;
  final double? weight;
  final String? profileImageUrl;
  final List<Map<String, dynamic>>? healthRecords;
  final RxBool isFavorite;

  PetModel({
    required this.id,
    required this.name,
    required this.type,
    this.breed,
    this.birthDate,
    this.gender,
    this.weight,
    this.profileImageUrl,
    this.healthRecords,
    bool isFavorite = false,
  }) : isFavorite = isFavorite.obs;

  // Get age in years and months
  String get age {
    if (birthDate == null) return 'Unknown';

    final now = DateTime.now();
    final difference = now.difference(birthDate!);
    final years = (difference.inDays / 365).floor();
    final months = ((difference.inDays % 365) / 30).floor();

    if (years > 0) {
      return months > 0 ? '$years years, $months months' : '$years years';
    } else {
      return '$months months';
    }
  }

  // Factory constructor from JSON
  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      breed: json['breed'] as String?,
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate'] as String)
          : null,
      gender: json['gender'] as String?,
      weight:
          json['weight'] != null ? (json['weight'] as num).toDouble() : null,
      profileImageUrl: json['profileImageUrl'] as String?,
      healthRecords: json['healthRecords'] != null
          ? List<Map<String, dynamic>>.from(json['healthRecords'] as List)
          : null,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'breed': breed,
      'birthDate': birthDate?.toIso8601String(),
      'gender': gender,
      'weight': weight,
      'profileImageUrl': profileImageUrl,
      'healthRecords': healthRecords,
      'isFavorite': isFavorite.value,
    };
  }

  // Create a copy with updated fields
  PetModel copyWith({
    String? id,
    String? name,
    String? type,
    String? breed,
    DateTime? birthDate,
    String? gender,
    double? weight,
    String? profileImageUrl,
    List<Map<String, dynamic>>? healthRecords,
    bool? isFavorite,
  }) {
    return PetModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      breed: breed ?? this.breed,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      healthRecords: healthRecords ?? this.healthRecords,
      isFavorite: isFavorite ?? this.isFavorite.value,
    );
  }
}
