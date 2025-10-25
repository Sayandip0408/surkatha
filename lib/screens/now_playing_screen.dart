import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../main.dart';
import '../models/song.dart';
import 'package:just_audio/just_audio.dart';

class NowPlayingScreen extends StatefulWidget {
  final Song song;
  const NowPlayingScreen({super.key, required this.song});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    if (widget.song.uri == null) return;
    await _player.setAudioSource(AudioSource.uri(Uri.parse(widget.song.uri!)));

    _player.durationStream.listen((d) {
      if (d != null) setState(() => _duration = d);
    });

    audioHandler.playMedia(widget.song.uri!);
    setState(() => _isPlaying = true);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _formatTime(Duration d) {
    return "${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final double imageRadius = 30;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          widget.song.title,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFff6a00), Color(0xFFee0979)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(imageRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha((0.1 * 255).round()),
                    borderRadius: BorderRadius.circular(imageRadius),
                    border: Border.all(
                      color: Colors.white.withAlpha((0.2 * 255).round()),
                    ),
                  ),
                  child: QueryArtworkWidget(
                    id: int.tryParse(widget.song.id) ?? 0,
                    type: ArtworkType.AUDIO,
                    artworkBorder: BorderRadius.circular(imageRadius),
                    nullArtworkWidget: const Icon(
                      Icons.music_note,
                      size: 200,
                      color: Colors.white,
                    ),
                    artworkFit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            Text(
              widget.song.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.song.artist,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            StreamBuilder<Duration>(
              stream: _player.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final progress = _duration.inMilliseconds == 0
                    ? 0.0
                    : position.inMilliseconds / _duration.inMilliseconds;

                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha((0.1 * 255).round()),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white.withAlpha((0.2 * 255).round()),
                        ),
                      ),
                      child: Column(
                        children: [
                          Slider(
                            value: progress.clamp(0.0, 1.0),
                            activeColor: Colors.white,
                            inactiveColor: Colors.white38,
                            onChanged: (v) {
                              final newPos = _duration * v;
                              _player.seek(newPos);
                            },
                          ),
                          Text(
                            "${_formatTime(position)} / ${_formatTime(_duration)}",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 32),

            StreamBuilder<PlayerState>(
              stream: _player.playerStateStream,
              builder: (context, snapshot) {
                final playing = snapshot.data?.playing ?? _isPlaying;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (playing) {
                          audioHandler.pause();
                        } else {
                          // audioHandler.playMedia(widget.song.uri!);
                          audioHandler.play();
                        }
                        setState(() => _isPlaying = !playing);
                      },
                      iconSize: 64,
                      icon: Icon(
                        playing
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_filled,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
