import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';

class Player extends RiveComponent {
  final Artboard playerArtboard;
  late RiveComponent player;
  double x = 0;
  double y = 0;
  Player({required this.playerArtboard}) : super(artboard: playerArtboard);
  @override
  Future<void> onLoad() async{
    player = RiveComponent(artboard: playerArtboard);
    add(player
    ..position = Vector2(x, y)
    );
  }

  @override
  void update(double dt) {
    // player.x = ;
    // player.y = ;
    super.update(dt);
  }
}