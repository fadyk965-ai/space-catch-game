import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/game_object.dart';

/// Game engine that handles all game logic and state
class GameEngine {
  final StreamController<List<GameObject>> _objectsStreamController =
      StreamController.broadcast();
  final StreamController<int> _scoreStreamController =
      StreamController.broadcast();
  final StreamController<int> _highScoreStreamController =
      StreamController.broadcast();
  final StreamController<double> _playerStreamController =
      StreamController.broadcast();
  final StreamController<bool> _shieldStreamController =
      StreamController.broadcast();
  final StreamController<Offset?> _explosionStreamController =
      StreamController.broadcast();

  Stream<List<GameObject>> get objectsStream => _objectsStreamController.stream;
  Stream<int> get scoreStream => _scoreStreamController.stream;
  Stream<int> get highScoreStream => _highScoreStreamController.stream;
  Stream<double> get playerStream => _playerStreamController.stream;
  Stream<bool> get shieldStream => _shieldStreamController.stream;
  Stream<Offset?> get explosionStream => _explosionStreamController.stream;

  Timer? _gameLoopTimer;
  Timer? _spawnerTimer;
  Timer? _shieldTimer;

  List<GameObject> _activeObjects = [];
  double playerX = 0.0;
  int _score = 0;
  int _highScore = 0;
  bool isGameOver = false;
  bool isShieldActive = false;
  int _objectIdCounter = 0;
  double _baseSpeedModifier = 1.0;

  /// Starts a new game
  void startGame() {
    _cleanup();
    _score = 0;
    isGameOver = false;
    isShieldActive = false;
    _baseSpeedModifier = 1.0;
    _activeObjects.clear();
    playerX = 0.0;

    _scoreStreamController.add(_score);
    _highScoreStreamController.add(_highScore);
    _playerStreamController.add(playerX);
    _shieldStreamController.add(false);
    _explosionStreamController.add(null);

    _gameLoopTimer = Timer.periodic(const Duration(milliseconds: 16), (_) => _updateGameLoop());
    _spawnerTimer = Timer.periodic(const Duration(milliseconds: 650), (_) => _spawnObject());
  }

  /// Spawns a new game object
  void _spawnObject() {
    if (isGameOver) return;

    final random = Random();
    ObjectType type;
    double randVal = random.nextDouble();

    if (randVal < 0.10) {
      type = ObjectType.shield;
    } else if (randVal < 0.45) {
      type = ObjectType.reward;
    } else {
      type = ObjectType.obstacle;
    }

    _activeObjects.add(
      GameObject(
        id: _objectIdCounter++,
        x: (random.nextDouble() * 1.6) - 0.8,
        y: -1.2,
        type: type,
        speed: (0.012 + (random.nextDouble() * 0.012)) * _baseSpeedModifier,
        size: 38 + (random.nextDouble() * 20),
      ),
    );
  }

  /// Updates the game state each frame
  void _updateGameLoop() {
    if (isGameOver) return;

    List<GameObject> updatedList = [];

    for (var obj in _activeObjects) {
      obj.y += obj.speed;

      if (obj.y > 0.65 && obj.y < 0.95 && (obj.x - playerX).abs() < 0.28) {
        if (obj.type == ObjectType.reward) {
          _handleRewardCollision();
        } else if (obj.type == ObjectType.shield) {
          _activateShield();
        } else if (obj.type == ObjectType.obstacle) {
          _handleObstacleCollision(obj);
          return;
        }
      } else if (obj.y <= 1.2) {
        updatedList.add(obj);
      }
    }

    _activeObjects = updatedList;
    _objectsStreamController.add(List.from(_activeObjects));
  }

  /// Handles reward collection
  void _handleRewardCollision() {
    _score += 10;
    if (_score > _highScore) {
      _highScore = _score;
      _highScoreStreamController.add(_highScore);
    }
    _scoreStreamController.add(_score);
    _baseSpeedModifier = 1.0 + (_score / 100) * 0.2;
  }

  /// Handles obstacle collision
  void _handleObstacleCollision(GameObject obstacle) {
    if (isShieldActive) {
      _explosionStreamController.add(Offset(obstacle.x, obstacle.y));
    } else {
      _explosionStreamController.add(Offset(playerX, 0.85));
      _triggerGameOver();
    }
  }

  /// Activates the shield for 5 seconds
  void _activateShield() {
    isShieldActive = true;
    _shieldStreamController.add(true);
    _shieldTimer?.cancel();
    _shieldTimer = Timer(const Duration(seconds: 5), () {
      isShieldActive = false;
      _shieldStreamController.add(false);
    });
  }

  /// Updates the player position
  void updatePlayerPosition(double newX) {
    if (isGameOver) return;
    playerX = newX.clamp(-0.85, 0.85);
    _playerStreamController.add(playerX);
  }

  /// Triggers game over state
  void _triggerGameOver() {
    isGameOver = true;
    _cleanup();
    _objectsStreamController.add([]);
  }

  /// Cleans up all timers
  void _cleanup() {
    _gameLoopTimer?.cancel();
    _spawnerTimer?.cancel();
    _shieldTimer?.cancel();
  }

  /// Disposes all resources
  void dispose() {
    _cleanup();
    _objectsStreamController.close();
    _scoreStreamController.close();
    _highScoreStreamController.close();
    _playerStreamController.close();
    _shieldStreamController.close();
    _explosionStreamController.close();
  }
}

