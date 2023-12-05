class Slide {
  final int id;
  final String title;
  final String image;

  Slide({required this.id, required this.title, required this.image});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image_url': image,
    };
  }

  factory Slide.fromMap(Map<String, dynamic> map) {
    return Slide(
      id: map['id'] as int,
      title: map['title'] as String,
      image: map['image_url'] as String,
    );
  }
}