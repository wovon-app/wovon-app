class Wovpost {
  final int id;
  final String title;
  final String? description;
  final double latitude;
  final double longitude;
  final String? image;

  // etc. (Agregar los campos que se necesiten)

  const Wovpost({
    required this.id,
    required this.title,
    required this.latitude,
    required this.longitude,
    this.description,
    this.image,
  });

  factory Wovpost.fromJson(Map<String, dynamic> json) {
    return Wovpost(
      id: json['id'] as int,
      title: json['title'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      description: json['description'] as String?,
      image: json['image'] as String?,

      // etc. (Agregar los campos que se necesiten)
    );
  }
}
