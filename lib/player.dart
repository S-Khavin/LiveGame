import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:livegame/main.dart';

class Player extends RiveComponent with HasGameRef<SumoGame> {
  final Artboard playerArtboard;
  late RiveComponent player;
  Player({required this.playerArtboard})
      : super(
          artboard: playerArtboard,
          anchor: Anchor.center,
          size: Vector2(25, 25),
        );
  @override
  Future<void> onLoad() async {
    player = RiveComponent(artboard: playerArtboard);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
