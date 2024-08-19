class TaskModel {
  String? id;
  String name;

  TaskModel({
    this.id,
    required this.name,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'] is int ? json['id'].toString() : json['id'],
        name: json['name'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
