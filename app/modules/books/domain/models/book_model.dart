class BookModel {
  String? id;
  String name;

  BookModel({
    this.id,
    required this.name,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json['id'] is int ? json['id'].toString() : json['id'],
        name: json['name'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
