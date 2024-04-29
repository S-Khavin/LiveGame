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
  runApp(GameWidget(game: SumoGame(riveFile: riveFile),));
}

class SumoGame extends FlameGame{
  final databaseReference = FirebaseDatabase.instance.ref();
  final RiveFile riveFile;
  SumoGame({required this.riveFile});
  late Player player;
  @override
  Future<void> onLoad() async{
    player = Player(playerArtboard: riveFile.artboardByName('Player')!
    );
    add(player);
  }
}