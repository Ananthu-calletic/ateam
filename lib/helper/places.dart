class Place {
  String placeName;
  double latitude;
  double longitude;

  Place({
    required this.placeName,
    required this.latitude,
    required this.longitude,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeName: json['place_name'] ?? '',
      latitude: (json['center'][1] as num).toDouble(),
      longitude: (json['center'][0] as num).toDouble(),
    );
  }
}
