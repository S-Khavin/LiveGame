import 'package:firebase_database/firebase_database.dart';
import 'package:flame/game.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:livegame/player.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  RiveFile riveFile = await RiveFile.asset('assets/rive/rive.riv');
  runApp(GameWidget(
    game: SumoGame(riveFile: riveFile),
  ));
}

class SumoGame extends FlameGame {
  DatabaseReference xPos = FirebaseDatabase.instance.ref().child('x');
  DatabaseReference yPos = FirebaseDatabase.instance.ref().child('y');
  double x = 0;
  double y = 0;
  final RiveFile riveFile;
  SumoGame({required this.riveFile});
  late Player player;
  @override
  Future<void> onLoad() async {
    player = Player(playerArtboard: riveFile.artboardByName('Player')!);
    xPos.onValue.listen((event) {
      x = event.snapshot.value as double;
      print(x);
    });
    yPos.onValue.listen((event) {
      y = event.snapshot.value as double;
      print(y);
    });
    add(player);
  }

  @override
  void update(double dt) {
    player.position = Vector2(x, y);
    super.update(dt);
  }
}
