import 'package:firebase_database/firebase_database.dart';
import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';

class Player extends RiveComponent {
  final Artboard playerArtboard;
  late RiveComponent player;
  DatabaseReference playerRef =
        FirebaseDatabase.instance.ref().child('player');
  Player({required this.playerArtboard})
      : super(
            artboard: playerArtboard,
            anchor: Anchor.center,
            size: Vector2(25, 25));
  @override
  Future<void> onLoad() async {
    player = RiveComponent(artboard: playerArtboard);

  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
