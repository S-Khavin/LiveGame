import 'package:firebase_database/firebase_database.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
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

class SumoGame extends FlameGame with DragCallbacks {
  late JoystickComponent joystick;
  DatabaseReference xPos = FirebaseDatabase.instance.ref().child('x');
  DatabaseReference yPos = FirebaseDatabase.instance.ref().child('y');
  double x = 0;
  double y = 0;
  final RiveFile riveFile;
  SumoGame({required this.riveFile});
  late Player player;
  @override
  Future<void> onLoad() async {
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 100, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    add(joystick);
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
    player.position.add(joystick.delta * 10 * dt);
    // updatePlayerPosition(player.x, player.y);
       // Limit database updates to reduce load
    if (x != player.position.x) {
      x = player.position.x;
      xPos.set(x);
    }
    if (y != player.position.y) {
      y = player.position.y;
      yPos.set(y);
    }
    super.update(dt);

  }
}
