import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'services/audio_handler.dart';
import 'app.dart';
import 'providers/music_provider.dart';
import 'package:provider/provider.dart';

late final AudioPlayerHandler audioHandler;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Modern initialization
  audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.example.surkatha.channel.audio',
      androidNotificationChannelName: 'Surkatha Music',
      androidNotificationOngoing: true,       // persistent notification
      androidStopForegroundOnPause: true,     // must be true if ongoing
    ),
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => MusicProvider(),
      child: const SurkathaApp(),
    ),
  );
}
