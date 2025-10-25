import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import 'now_playing_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MusicProvider>(context);
    final likedSongs = provider.likedSongs;

    if (likedSongs.isEmpty) {
      return const Center(child: Text("No liked songs yet ❤️"));
    }

    return ListView.builder(
      itemCount: likedSongs.length,
      itemBuilder: (context, index) {
        final song = likedSongs[index];
        return ListTile(
          leading: const Icon(Icons.music_note),
          title: Text(song.title),
          subtitle: Text(song.artist),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NowPlayingScreen(song: song),
              ),
            );
          },
        );
      },
    );
  }
}
