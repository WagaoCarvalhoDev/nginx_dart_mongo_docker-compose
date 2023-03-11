class ClientModel {
  String? name;

  ClientModel();

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory ClientModel.fromRequest(Map map) {
    return ClientModel()..name = map['name'];
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel()..name = map['name'];
  }
}
