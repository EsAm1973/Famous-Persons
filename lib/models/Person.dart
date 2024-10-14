// ignore_for_file: public_member_api_docs, sort_constructors_first
class Person {
  int id;
  String name;
  String category;
  Person({
    required this.id,
    required this.name,
    required this.category,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      category: json['known_for_department'],
    );
  }
}
