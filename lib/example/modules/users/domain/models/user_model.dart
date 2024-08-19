class UserModel {
  String? id;
  String name;

  UserModel({
    this.id,
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] is int ? json['id'].toString() : json['id'],
        name: json['name'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
