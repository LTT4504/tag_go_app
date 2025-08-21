class Spot {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final List<String> favorites; // món yêu thích
  final List<String> photos;    // url ảnh
  final String mood;            // emoji/text
  final String note;
  final bool isPrivate;
  final DateTime createdAt;

  Spot({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    this.favorites = const [],
    this.photos = const [],
    this.mood = '',
    this.note = '',
    this.isPrivate = true,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
    'id': id, 'name': name, 'lat': lat, 'lng': lng, 'favorites': favorites,
    'photos': photos, 'mood': mood, 'note': note, 'isPrivate': isPrivate,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Spot.fromMap(Map<String, dynamic> m) => Spot(
    id: m['id'], name: m['name'], lat: (m['lat'] as num).toDouble(),
    lng: (m['lng'] as num).toDouble(),
    favorites: List<String>.from(m['favorites'] ?? []),
    photos: List<String>.from(m['photos'] ?? []),
    mood: m['mood'] ?? '', note: m['note'] ?? '',
    isPrivate: m['isPrivate'] ?? true,
    createdAt: DateTime.tryParse(m['createdAt'] ?? '') ?? DateTime.now(),
  );
}
