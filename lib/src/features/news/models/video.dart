class Video {
  final int id;
  final String title;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final int likes;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.likes,
  });

    Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'likes': likes,
      'video_url': videoUrl,
      'thumbnail_url': thumbnailUrl,
    };
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      likes: map['likes'] ?? 0,
      videoUrl: map['video_url'] as String,
      thumbnailUrl: map['thumbnail_url'] as String,
    );
  }
}