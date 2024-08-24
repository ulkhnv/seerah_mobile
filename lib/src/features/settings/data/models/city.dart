class City {
  final String name;
  final String timezone;
  final String slug;

  const City({required this.name, required this.timezone, required this.slug});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        name: json['name'] as String,
        timezone: json['timezone'] as String,
        slug: json['slug'] as String);
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "timezone": timezone, "slug": slug};
  }
}
