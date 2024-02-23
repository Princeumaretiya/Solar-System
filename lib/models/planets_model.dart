class PlanetInfo {
  final String? name;
  final String? iconImage;
  final String? description;
  final List images;

  PlanetInfo({
    this.name,
    this.iconImage,
    this.description,
    required this.images,
  });

  factory PlanetInfo.fromMap({required Map planet}) {
    return PlanetInfo(
      description: planet['description'],
      iconImage: planet['iconImage'],
      images: planet['images'],
      name: planet['name'],
    );
  }
}
