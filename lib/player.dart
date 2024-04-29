import 'package:firebase_database/firebase_database.dart';
import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';

class Player extends RiveComponent {
  final Artboard playerArtboard;
  late RiveComponent player;
  DatabaseReference xPos = FirebaseDatabase.instance.ref().child('x');
  DatabaseReference yPos = FirebaseDatabase.instance.ref().child('y');
  DatabaseReference dbcount = FirebaseDatabase.instance.ref().child('count');
  double x = 0;
  double y = 0;
  String count = "none";
  Player({required this.playerArtboard})
      : super(
          artboard: playerArtboard,
          anchor: Anchor.center,
          size: Vector2(25, 25),
        );
  @override
  Future<void> onLoad() async {
    player = RiveComponent(artboard: playerArtboard);
    xPos.onValue.listen((event) {
      x = event.snapshot.value as double;
      player.x = x;
      print(x);
    });
    yPos.onValue.listen((event) {
       y = event.snapshot.value as double;
      player.y = y;
    });
      dbcount.onValue.listen((event) {
      String count = event.snapshot.value.toString();
      print(count);
    });
  }

  @override
  void update(double dt) {
    super.update(dt);
    player.position = Vector2(x, y);
    print(x);
    print(y);
  }
}
