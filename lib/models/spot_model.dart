class Spot {
  String id;
  String name;
  List<String> favorites;
  String note;
  String placeType;
  bool isPrivate;
  String mood;
  double lat;
  double lng;

  Spot({
    required this.id,
    required this.name,
    required this.favorites,
    required this.note,
    required this.placeType,
    required this.isPrivate,
    required this.mood,
    required this.lat,
    required this.lng,
  });

  factory Spot.empty() => Spot(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: '',
        favorites: [],
        note: '',
        placeType: 'drink',
        isPrivate: false,
        mood: '',
        lat: 0,
        lng: 0,
      );

  factory Spot.fromJson(Map<String, dynamic> json) => Spot(
        id: json['id']?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: json['name'] ?? '',
        favorites: (json['favorites'] as List?)?.map((e) => e.toString()).toList() ?? [],
        note: json['note'] ?? '',
        placeType: json['placeType'] ?? json['type'] ?? 'drink',
        isPrivate: json['isPrivate'] ?? false,
        mood: json['mood'] ?? '',
        lat: (json['lat'] ?? 0).toDouble(),
        lng: (json['lng'] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'favorites': favorites,
        'note': note,
        'placeType': placeType,
        'isPrivate': isPrivate,
        'mood': mood,
        'lat': lat,
        'lng': lng,
      };
}
