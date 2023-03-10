class ClientModel {
  final String name;

  ClientModel({required this.name});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      name: map['name'] as String,
    );
  }
}
