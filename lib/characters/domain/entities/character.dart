enum CharacterStatus { alive, dead, unknown }

enum CharacterGender { female, male, genderless, unknown }

class Character {
  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.originName,
    required this.locationName,
    required this.imageUrl,
    required this.episodeCount,
  });

  final int id;
  final String name;
  final CharacterStatus status;
  final String species;
  final String type;
  final CharacterGender gender;
  final String originName;
  final String locationName;
  final String imageUrl;
  final int episodeCount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Character &&
          other.id == id &&
          other.name == name &&
          other.status == status &&
          other.species == species &&
          other.type == type &&
          other.gender == gender &&
          other.originName == originName &&
          other.locationName == locationName &&
          other.imageUrl == imageUrl &&
          other.episodeCount == episodeCount;

  @override
  int get hashCode => Object.hash(
    id,
    name,
    status,
    species,
    type,
    gender,
    originName,
    locationName,
    imageUrl,
    episodeCount,
  );

  @override
  String toString() => 'Character($id, $name)';
}
