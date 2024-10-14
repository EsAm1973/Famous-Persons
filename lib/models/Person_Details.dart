class PersonDetails {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String biography;
  final String placeOfBirth;
  final String profilePath;
  final double popularity;

  PersonDetails({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.biography,
    required this.placeOfBirth,
    required this.profilePath,
    required this.popularity,
  });

  factory PersonDetails.fromJson(Map<String, dynamic> json) {
    return PersonDetails(
      adult: json['adult'],
      gender: json['gender'],
      id: json['id'],
      knownForDepartment: json['known_for_department'],
      name: json['name'],
      biography: json['biography'],
      placeOfBirth: json['place_of_birth'],
      profilePath: json['profile_path'],
      popularity: json['popularity'].toDouble(),
    );
  }
}