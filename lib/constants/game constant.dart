/// Game constants and configuration values
class GameConstants {
  // Game object spawn chances
  static const double shieldSpawnChance = 0.10;
  static const double rewardSpawnChance = 0.45;

  // Game object properties
  static const double minObjectSpeed = 0.012;
  static const double maxObjectSpeedVariation = 0.012;
  static const double minObjectSize = 38;
  static const double maxObjectSizeVariation = 20;

  // Initial object spawn position
  static const double initialSpawnX = 1.6;
  static const double initialSpawnY = -1.2;
  static const double spawnXOffset = 0.8;

  // Player position
  static const double playerMaxX = 0.85;
  static const double playerMinX = -0.85;
  static const double playerCollisionY = 0.85;
  static const double collisionDetectionMinY = 0.65;
  static const double collisionDetectionMaxY = 0.95;
  static const double collisionDetectionRadius = 0.28;

  // Game speeds
  static const double baseSpeedModifier = 1.0;
  static const double speedIncreasePerScore = 0.2;
  static const double scoreSpeedDivisor = 100;

  // Timers
  static const Duration gameLoopDuration = Duration(milliseconds: 16);
  static const Duration spawnerDuration = Duration(milliseconds: 650);
  static const Duration shieldActiveDuration = Duration(seconds: 5);
  static const Duration explosionDuration = Duration(milliseconds: 400);
  static const Duration backgroundAnimationDuration = Duration(seconds: 10);

  // Scoring
  static const int rewardPoints = 10;

  // UI Colors
  static const int darkBackgroundColor = 0xFF030712;
  static const int dialogBackgroundColor = 0xFF1E293B;
  static const int playerColor = 0xFF6366F1;
  static const int shieldColor = 0xFF06B6D4;
  static const int rewardColor = 0xFF10B981;
  static const int obstacleColor = 0xFFEF4444;

  // UI Dimensions
  static const double playerShipSize = 60;
  static const double playerIconSize = 34;
  static const double thrustFlameWidth = 20;
  static const double thrustFlameHeight = 15;
  static const double explosionSize = 50;
  static const double starSize = 1.5;

  // UI Spacing
  static const double topPadding = 20;
  static const double horizontalPadding = 20;
  static const double scoreContainerPadding = 8;
  static const double scoreContainerHorizontalPadding = 16;
  static const double scoreFontSize = 16;
  static const double highScoreFontSize = 16;

  // Background
  static const int starFieldCount = 30;
  static const double starOpacity = 0.3;
  static const double objectRemovalThreshold = 1.2;
}

