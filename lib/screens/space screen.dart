enum ObjectType { reward, obstacle, shield }
class GameObject {
  final int id;
  double x;
  double y;
  final ObjectType type;
  final double speed;
  final double size;

  GameObject({
    required this.id,
    required this.x,
    required this.y,
    required this.type,
    required this.speed,
    required this.size,
  });
}

