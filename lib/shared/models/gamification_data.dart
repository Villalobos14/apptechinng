// lib/shared/models/gamification_data.dart

class GamificationData {
  final int pointsEarned;
  final int totalPoints;
  final int currentLevel;
  final int pointsToNextLevel;
  final String skillPracticed;
  final List<String> achievementsUnlocked;
  final int streakDays;
  final bool leveledUp;

  const GamificationData({
    required this.pointsEarned,
    required this.totalPoints,
    required this.currentLevel,
    required this.pointsToNextLevel,
    required this.skillPracticed,
    this.achievementsUnlocked = const [],
    this.streakDays = 0,
    this.leveledUp = false,
  });

  factory GamificationData.fromJson(Map<String, dynamic> json) {
    return GamificationData(
      pointsEarned: json['pointsEarned'] as int,
      totalPoints: json['totalPoints'] as int,
      currentLevel: json['currentLevel'] as int,
      pointsToNextLevel: json['pointsToNextLevel'] as int,
      skillPracticed: json['skillPracticed'] as String,
      achievementsUnlocked: List<String>.from(json['achievementsUnlocked'] ?? []),
      streakDays: json['streakDays'] as int? ?? 0,
      leveledUp: json['leveledUp'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pointsEarned': pointsEarned,
      'totalPoints': totalPoints,
      'currentLevel': currentLevel,
      'pointsToNextLevel': pointsToNextLevel,
      'skillPracticed': skillPracticed,
      'achievementsUnlocked': achievementsUnlocked,
      'streakDays': streakDays,
      'leveledUp': leveledUp,
    };
  }

  // Factory para crear datos de ejemplo
  factory GamificationData.example({
    int pointsEarned = 10,
    String skillName = 'Conflict Resolution',
  }) {
    return GamificationData(
      pointsEarned: pointsEarned,
      totalPoints: 500 + pointsEarned,
      currentLevel: 5,
      pointsToNextLevel: 80,
      skillPracticed: skillName,
      achievementsUnlocked: [],
      streakDays: 3,
      leveledUp: false,
    );
  }

  GamificationData copyWith({
    int? pointsEarned,
    int? totalPoints,
    int? currentLevel,
    int? pointsToNextLevel,
    String? skillPracticed,
    List<String>? achievementsUnlocked,
    int? streakDays,
    bool? leveledUp,
  }) {
    return GamificationData(
      pointsEarned: pointsEarned ?? this.pointsEarned,
      totalPoints: totalPoints ?? this.totalPoints,
      currentLevel: currentLevel ?? this.currentLevel,
      pointsToNextLevel: pointsToNextLevel ?? this.pointsToNextLevel,
      skillPracticed: skillPracticed ?? this.skillPracticed,
      achievementsUnlocked: achievementsUnlocked ?? this.achievementsUnlocked,
      streakDays: streakDays ?? this.streakDays,
      leveledUp: leveledUp ?? this.leveledUp,
    );
  }

  @override
  String toString() {
    return 'GamificationData(pointsEarned: $pointsEarned, totalPoints: $totalPoints, level: $currentLevel, skill: $skillPracticed)';
  }
}