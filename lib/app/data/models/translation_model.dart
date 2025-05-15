class TranslationModel {
  final String id;
  final String petId;
  final String mode; // 'pet-to-human' or 'human-to-pet'
  final String petType; // 'dog' or 'cat'
  final String? audioPath;
  final String originalText;
  final String translatedText;
  final DateTime createdAt;
  final String language;
  final bool isFavorite;

  TranslationModel({
    required this.id,
    required this.petId,
    required this.mode,
    required this.petType,
    this.audioPath,
    required this.originalText,
    required this.translatedText,
    required this.createdAt,
    required this.language,
    this.isFavorite = false,
  });

  // Factory constructor from JSON
  factory TranslationModel.fromJson(Map<String, dynamic> json) {
    return TranslationModel(
      id: json['id'] as String,
      petId: json['petId'] as String,
      mode: json['mode'] as String,
      petType: json['petType'] as String,
      audioPath: json['audioPath'] as String?,
      originalText: json['originalText'] as String,
      translatedText: json['translatedText'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      language: json['language'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'petId': petId,
      'mode': mode,
      'petType': petType,
      'audioPath': audioPath,
      'originalText': originalText,
      'translatedText': translatedText,
      'createdAt': createdAt.toIso8601String(),
      'language': language,
      'isFavorite': isFavorite,
    };
  }

  // Create a copy with updated fields
  TranslationModel copyWith({
    String? id,
    String? petId,
    String? mode,
    String? petType,
    String? audioPath,
    String? originalText,
    String? translatedText,
    DateTime? createdAt,
    String? language,
    bool? isFavorite,
  }) {
    return TranslationModel(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      mode: mode ?? this.mode,
      petType: petType ?? this.petType,
      audioPath: audioPath ?? this.audioPath,
      originalText: originalText ?? this.originalText,
      translatedText: translatedText ?? this.translatedText,
      createdAt: createdAt ?? this.createdAt,
      language: language ?? this.language,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
