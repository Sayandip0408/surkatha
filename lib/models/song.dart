class Song {
  final String id;
  final String title;
  final String artist;
  final String? albumArtPath;
  final Duration duration;
  final String? uri;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    this.albumArtPath,
    required this.duration,
    this.uri,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'artist': artist,
    'albumArtPath': albumArtPath,
    'duration': duration.inMilliseconds,
    'uri': uri,
  };

  factory Song.fromMap(Map<String, dynamic> m) => Song(
    id: m['id'] as String,
    title: m['title'] as String,
    artist: m['artist'] as String,
    albumArtPath: m['albumArtPath'] as String?,
    duration: Duration(milliseconds: m['duration'] as int),
    uri: m['uri'] as String?,
  );
}
