class Wovpost {
  final int id;
  final String title;
  final double latitude;
  final double longitude;
  final String category;
  final String? image;

  // etc. (Agregar los campos que se necesiten)

  const Wovpost({
    required this.id,
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.category,
    this.image,
  });

  factory Wovpost.fromJson(Map<String, dynamic> json) {
    return Wovpost(
      id: json['id'] as int,
      title: json['title'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      category: ApiCategory.fromJson(json['category']).name,
      image: json['image'] as String?,
      // etc. (Agregar los campos que se necesiten)
    );
  }
}

class ApiCategory {
  final String name;

  const ApiCategory({
    required this.name
  });

  factory ApiCategory.fromJson (Map<String,dynamic> json) {
    return ApiCategory(name: json['name'] as String);
  }
}